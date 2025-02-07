local cabin = {}

function cabin.setup()
	local has_treesitter, parsers = pcall(require, "nvim-treesitter.parsers")

	-- Devicons
	local has_devicons, devicons = pcall(require, "nvim-web-devicons")
	if has_devicons then
		devicons.set_icon({
			cabin = {
				icon = "",
				color = "#8a542d",
				name = "Cabin"
			}
		})
	end

	-- Treesitter
	if has_treesitter and not parsers.has_parser("cabin") then
		---@diagnostic disable-next-line: inject-field
		parsers.get_parser_configs().cabin = {
			install_info = {
				url = "https://github.com/cabin-language/tree-sitter-cabin.git",
				branch = "main",
				files = { "src/parser.c" },
			},
		}
		vim.treesitter.language.register('cabin', 'cabin')
		vim.cmd("TSInstall cabin")
	end

	-- LSP
	local cabin_path = vim.fn.stdpath("data") .. "/cabin"
	if not vim.uv.fs_stat(cabin_path) then
		vim.print("Downloading cabin language server...")
		vim.system({
			"git",
			"clone",
			"https://github.com/cabin-language/cabin.git",
			cabin_path,
		}):wait()

		vim.print("Compiling cabin language server...")
		vim.system({ "cargo", "run", "--release" }, { cwd = cabin_path .. "/crates/cabin-language-server", }):wait()
		vim.print("Done! Cabin server ready.")
	end

	vim.api.nvim_create_autocmd("BufRead", {
		pattern = "*.cabin",
		callback = function(args)
			vim.bo.filetype = "cabin"
			local client = vim.lsp.start({
				name = "cabin-language-server",
				cmd = { cabin_path .. "/crates/cabin-language-server/target/release/cabin-language-server" }
			})
			---@cast client integer
			if not vim.lsp.buf_attach_client(args.buf, client) then
				print("Failed to attach Cabin LSP client to buffer.")
			end
		end
	})
end

return cabin
