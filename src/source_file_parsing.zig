const stdzig = @import("stdzig/stdzig.zig");
    const collections = stdzig.collections;
        const Vec = collections.Vec;


/// Content of the given source file
pub var file_content: Vec(u8) = undefined;

/// Currently selected byte in the source file
pub var current_byte_address: usize = 0;
