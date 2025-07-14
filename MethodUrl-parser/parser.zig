const std = @import("std");

const Request = struct {
    method: []const u8,
    url: []const u8,
};

fn parseRequest(input: []const u8) !Request {
    const trimmed = std.mem.trim(u8, input, " \t\r\n");

    const space_index = std.mem.indexOfScalar(u8, trimmed, ' ') orelse {
        return error.InvalidRequest;
    };

    const method = trimmed[0..space_index];

    const url = std.mem.trimLeft(u8, trimmed[space_index + 1 ..], " ");

    const valid_methods = [_][]const u8{ "GET", "POST", "PUT", "DELETE" };
    var is_valid_method = false;
    for(valid_methods) |valid_method| {
        if(std.mem.eql(u8, method, valid_method)) {
            is_valid_method = true;
            break;
        }
    }
    if(!is_valid_method) {
        return error.InvalidRequest;
    }


    return Request {
        .method = method,
        .url = url,
    };
}

pub fn main() !void {
    const input = "GET http://example.com";

    const result = parseRequest(input) catch |err| {
        std.debug.print("Error parsing request: {}\n", .{err});
        return;
    };

    std.debug.print("Method: \"{s}\"\n", .{result.method});
    std.debug.print("Url: \"{s}\"\n", .{result.url});
}
