const std = @import("std");
    const OpenedFile = std.fs.File;

const Vec = @import("collections.zig").Vec;


const FSError = error {
    NotFound,
    Unknown,
};


/// Manages a file at a given local path for reading and writing
///
/// The file is only opened during direct manipulation and viewing phases, so this does not need to be defered
pub const File = struct {
    path: []const u8,

    /// Open the file at `path`
    pub fn open(path: []const u8) FSError! File {
        // Check if the given path is valid
        _ = std.fs.cwd().openFile(path, .{}) catch |err| { switch (err) {
            std.fs.File.OpenError.FileNotFound => return FSError.NotFound,
                                          else => return FSError.Unknown,
        }};

        // Return the constructed file
        return File{ .path = path };
    }

    /// Reads this file to a `Vec(u8)`
    pub fn read(self: *const File) Vec(u8) {
        // Open the file and get its size
        const opened_file = std.fs.cwd().openFile(self.path, .{}) catch unreachable;
            defer opened_file.close();
        const opened_file_size = opened_file.getEndPos() catch unreachable;

        // Create a new filled vector
        var file_content = Vec(u8).init_predef(opened_file_size, 0);

        // Set the vector's content to the file's content
        _ = opened_file.read(file_content.as_slice()) catch unreachable;

        // Return the file content
        return file_content;
    }
};
