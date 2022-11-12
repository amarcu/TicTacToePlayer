import subprocess
import sys
import json
from argparse import ArgumentParser

def main(contractName):
    run_command = "forge build"
    p = subprocess.Popen(run_command, stdout=subprocess.PIPE, shell=True)

    (output, err) = p.communicate()  

    p_status = p.wait()

    print("Command output: " + str(output))

    f = open("./out/"+contractName+".sol/"+contractName+".json", "r")
    outJson = json.loads(f.read())
    f.close()

    bytecode = outJson["bytecode"]["object"]

    print ("Bytecode successfully generated:\n\n " + bytecode)

if __name__=="__main__":
    parser = ArgumentParser()
    parser.add_argument("-c", "--contract", dest="contractName",
                    help="Name of the contract to extract the bytecode from")
    args = parser.parse_args()

    main(args.contractName)