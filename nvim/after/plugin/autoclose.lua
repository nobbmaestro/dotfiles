local status_ok = pcall(require, "autoclose")
if not status_ok then
    return
end

require("autoclose").setup()
