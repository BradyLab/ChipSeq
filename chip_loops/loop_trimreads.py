import commands
import os

def main(dir_file):
	for file_name in os.listdir(dir_file):
		cmd = "./trimReads -q 20 -m 20 " + dir_file + "/" + file_name
		print cmd
		commands.getoutput(cmd)

def bwa_loop(dir_file,index)
    for file_name in os.listdir(dir_file):
        sample_name = file_name.split(".")[0]
        cmd = "bwa aln -t 2 -l 20 {1}.fa {0}.fastq | bwa samse {1}.fa - {0}.fastq > {0}.sam".foramt(sample_name,index)
        commands.getoutput(cmd)

if __name__ == "__main__":
    import optparse
    parser = optparse.OptionParser("usage: %prog [options] ")
    parser.add_option("-p", dest="path", help="path to dir")
    (options, _) = parser.parse_args()

    main(options.path)
