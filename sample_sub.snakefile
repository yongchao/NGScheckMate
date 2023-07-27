shell.prefix("export LC_ALL=C; export LC_LANG=C; set -euo pipefail; ")

def get_config(key,default=""):
    val=config[key] if key in config else default
    return(val)

def get_config_dir(key,default="../"):
    dir=get_config(key,default)
    if dir[-1]!="/":
        dir=dir+"/"

    if dir=="./":
        dir=""
    return(dir)

#global variables
idir=get_config_dir("idir","../")
odir=get_config_dir("odir","./")

##These are used in the shell commands while the others are used in the rule
idir2=idir if idir!="" else "."
odir2=odir if odir!="" else "."

##set up gdir
refdata="/sc/arion/projects/sealfs01a/yongchao/motrpac_refdata/"
if "genome" in config:
    gdir=config["genome"]
    if gdir=="human":
        gdir="hg38_gencode_v30"
    elif gdir=="mouse":
        gdir="mm10_gencode_v19"
    elif gdir=="rat":
        gdir="rn6_ensembl_r96"
else:
    gdir="hg38_gencode_v30"
## if path is not given, attach the pathe
if gdir.find("/")<0:    
    gdir=refdata+gdir;

wildcard_constraints:
    sample="[^/]+"

#This needs to be modified when necessary
def get_samples(ext="_R1.fastq.gz"):
    samples,=glob_wildcards(idir+"{sample,[^/]+}"+ext)
    return(samples)

samples=get_samples()
