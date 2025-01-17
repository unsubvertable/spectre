const std = @import("std");
const c = @cImport({
    @cInclude("GLFW/glfw3.h");
});

pub fn main() !void {
    if (c.glfwInit() == 0) {
        return error.GlfwInitFailed;
    }
    defer c.glfwTerminate();

    const window = c.glfwCreateWindow(800, 600, "Spectre", null, null) orelse {
        return error.WindowCreationFailed;
    };
    defer c.glfwDestroyWindow(window);

    c.glfwMakeContextCurrent(window);

    while (c.glfwWindowShouldClose(window) == 0) {
        c.glfwPollEvents();

        c.glClear(c.GL_COLOR_BUFFER_BIT);

        c.glfwSwapBuffers(window);
    }
}
