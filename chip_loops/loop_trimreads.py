import commands
import os

def main(dir_file):
	for file_name in os.listdir(dir_file):
		cmd = "./trimReads -q 20 -m 20 " + dir_file + "/" + file_name
		print cmd
		commands.getoutput(cmd)


if __name__ == "__main__":
    import optparse
    parser = optparse.OptionParser("usage: %prog [options] ")
    parser.add_option("-p", dest="path", help="path to dir")
    (options, _) = parser.parse_args()

    main(options.path)
