import commands
import os
from multiprocessing import Pool


def print_and_run(cmd):
    print "running {0}".format(cmd)
    output = commands.getoutput(cmd)
    print output

def main(dir_file,cmd,ncpu):
    pool = Pool(ncpu)
    files = os.listdir(dir_file)
    run_cmds = []
    for file_name in files:
        ## grap every nth file with ncpu
        run_cmd = "{0} {1}/{2}".format(cmd,dir_file,file_name)
        run_cmds.append(run_cmd)
    pool.map(print_and_run, run_cmds)


if __name__ == "__main__":
    import optparse
    parser = optparse.OptionParser("usage: %prog [options] ")
    parser.add_option("--cmd", dest="cmd", help="path to dir")
    parser.add_option("--path", dest="path", help="path to dir")
    parser.add_option("--ncpu", dest="ncpu", help="path to dir")
    (options, _) = parser.parse_args()

    main(options.path,options.cmd,int(options.ncpu))
