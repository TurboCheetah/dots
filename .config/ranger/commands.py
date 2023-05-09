import os
import subprocess
from urllib.parse import quote

from ranger.api.commands import Command
from ranger.container.file import File
from ranger.ext.get_executables import get_executables


class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        import re
        from os import makedirs
        from os.path import expanduser, join, lexists

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search("^/|^~[^/]*/", dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0) :]

            for m in re.finditer("[^/]+", dirname):
                s = m.group(0)
                if s == ".." or (
                    s.startswith(".") and not self.fm.settings["show_hidden"]
                ):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console("scout -ae ^{}$".format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)


class YankContent(Command):
    """
    Copy the content of image file and text file with xclip
    """

    def execute(self):
        if "xclip" not in get_executables():
            self.fm.notify("xclip is not found.", bad=True)
            return

        arg = self.rest(1)
        if arg:
            if not os.path.isfile(arg):
                self.fm.notify("{} is not a file.".format(arg))
                return
            file = File(arg)
        else:
            file = self.fm.thisfile
            if not file.is_file:
                self.fm.notify("{} is not a file.".format(file.relative_path))
                return

        relative_path = file.relative_path
        cmd = ["xclip", "-selection", "clipboard"]
        if not file.is_binary():
            with open(file.path, "rb") as fd:
                subprocess.check_call(cmd, stdin=fd)
        elif file.image:
            cmd += ["-t", file.mimetype, file.path]
            subprocess.check_call(cmd)
            self.fm.notify(
                "Content of {} is copied to x clipboard".format(relative_path)
            )
        else:
            self.fm.notify(
                "{} is not an image file or a text file.".format(relative_path)
            )

    def tab(self, tabnum):
        return self._tab_directory_content()


class ass(Command):
    """
    Uploads the selected file to Ass
    """

    def execute(self):
        if "xclip" not in get_executables():
            self.fm.notify("xclip is not found.", bad=True)
            return

        arg = self.rest(1)
        if arg:
            if not os.path.isfile(arg):
                self.fm.notify("{} is not a file.".format(arg))
                return
            file = File(arg)
        else:
            file = self.fm.thisfile
            if not file.is_file:
                self.fm.notify("{} is not a file.".format(file.relative_path))
                return

        relative_path = file.relative_path
        ass_cmd = ["/home/turbo/.local/bin/ass", file.path]
        result = subprocess.run(
            ass_cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
        )

        if result.returncode != 0:
            self.fm.notify(f"Error running Ass: {result.stderr}", bad=True)
            return

        cmd = ["xclip", "-selection", "clipboard"]
        process = subprocess.Popen(cmd, stdin=subprocess.PIPE)
        process.communicate(input=result.stdout.strip().encode())
        self.fm.notify("Uploaded {} to Ass".format(relative_path))

    def tab(self, tabnum):
        return self._tab_directory_content()
