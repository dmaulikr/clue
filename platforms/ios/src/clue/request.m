#include "clue/request.h"

#import <Foundation/NSURL.h>
#import <Foundation/NSURLRequest.h>
#import <Foundation/NSURLResponse.h>
#import <Foundation/NSURLSession.h>
#import <Foundation/NSData.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSString.h>
#import <Foundation/NSCharacterSet.h>
#import <Foundation/NSArray.h>

#include <string.h>

void* clue_request_send(const clue_request_t* req, clue_request_callback_t callback, void* user)
{
	NSURL* url = [NSURL URLWithString:[NSString stringWithUTF8String:req->url]];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
	request.HTTPMethod = req->method ? [NSString stringWithUTF8String:req->method] : @"GET";
	request.HTTPBody = req->body ? [NSData dataWithBytes:req->body length:req->body_size] : nil;
	
	if (req->headers)
	{
		const char* end = req->headers + strlen(req->headers);
		
		const char* header_begin = req->headers;
		const char* header_end = NULL;
		
		while (header_begin < end && (header_end = strchr(header_begin, '\n')))
		{
			const char* header_colon = strchr(header_begin, ':');
			
			if (header_colon && header_colon < header_end)
			{
				NSString* name = [[NSString alloc]
					initWithBytes:header_begin
					length:header_colon - header_begin
					encoding:NSUTF8StringEncoding
				];
				
				NSString* value = [[NSString alloc]
					initWithBytes:header_colon + 1
					length:header_end - (header_colon + 1)
					encoding:NSUTF8StringEncoding
				];
				
				[request
					addValue:[value stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet]
					forHTTPHeaderField:[name stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet]
				];
			}
			
			header_begin = header_end + 1;
		}
	}
	
	NSURLSession* session = [[NSURLSession alloc] init];
	
	NSURLSessionDataTask* task = [session
		dataTaskWithRequest:request
		completionHandler:^(NSData* data, NSURLResponse* base_response, NSError* error) {
			NSHTTPURLResponse* response = (NSHTTPURLResponse*)base_response;
			
			clue_response_t resp;
			clue_response_init(&resp);
			
			char* body = NULL;
			
			if (error)
			{
				resp.error = [[NSString stringWithFormat:@"%@", error] UTF8String];
			}
			else
			{
				resp.code = (uint16_t)response.statusCode;
				
				NSMutableArray* headers = [[NSMutableArray alloc] init];
				for (NSString* name in response.allHeaderFields)
				{
					NSString* value = response.allHeaderFields[name];
					[headers addObject:[NSString stringWithFormat:@"%@: %@", name, value]];
				}
				
				resp.headers = [[headers componentsJoinedByString:@"\n"] UTF8String];
				
				size_t body_size = data ? data.length : 0;
				if (body_size)
				{
					body = malloc(body_size + 1);
					memcpy(body, [data bytes], body_size);
					body[body_size] = '\0';
					resp.body = body;
				}
			}
			
			callback(&resp, user);
			
			if (body) free(body);
		}
	];
	
	return (void*)CFBridgingRetain(task);
}

void clue_request_cancel(void* handle)
{
	if (!handle) return;
	
	NSURLSessionDataTask* task = (NSURLSessionDataTask*)CFBridgingRelease(handle);
	[task cancel];
}

void clue_request_finalize(void* handle)
{
	if (!handle) return;
	
	CFBridgingRelease(handle);
}
