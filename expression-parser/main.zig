const std = @import("std");

const Expression = struct {
    number: [10][]const u8,
    operator: [10][]const u8,
    num_count: usize,
    op_count: usize,
};

pub fn parseExpression(input: []const u8) !Expression {
    var expr = Expression {
        .number = undefined,
        .operator = undefined,
        .num_count = 0,
        .op_count = 0,
    };

    var tokens = [_][]const u8{""} ** 20; // 20 tokens capacity
    var token_count: usize = 0;

    var itr = std.mem.tokenizeScalar(u8, input, ' ');
    while(itr.next()) |token| {
        tokens[token_count] = token;
        token_count += 1;
    }

    for(tokens[0..token_count]) |token| {
        if(std.mem.eql(u8, token, "+") or std.mem.eql(u8, token, "-")) {
            expr.operator[expr.op_count] = token;
            expr.op_count += 1;
        }
        else {
            expr.number[expr.num_count] = token;
            expr.num_count += 1;
        }
    }

    return expr;
}

pub fn main() void {
    const input = "12 + 36 - 10";

    const result = try parseExpression(input);

    std.debug.print("Numbers:", .{});
    for(result.number[0..result.num_count]) |num| {
        std.debug.print(" {s}", .{num});
    }

    std.debug.print("\nOperator:", .{});
    for(result.operator[0..result.op_count]) |ops| {
        std.debug.print(" {s}", .{ops});
    }
}
