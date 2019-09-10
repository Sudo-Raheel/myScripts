VASP scripts
============

Script concerning post or pre treatments with VASP.

v
    Do simple operations to restart calculations with VASP and output some results. Some
    methods need pymatgen (`http://pymatgen.org`_) to be used. Execute v -h to see the 
    complete documentation.

moduleDOS.py
    Python module in order to interpret valence band using DOS and cross
    section from Scofield paper.

scofield.py
    Python script presenting an example of moduleDOS.py usage.

getCharges
    Compute atomic charges from a Bader caclculations done with the bader
    program of the University of Texas at Austin.
    Now included in v : v charges.

makeKpoins.py
    Create a KPOINTS file for a band structure calculation. This script use
    methods of pymatgen in order to compute and select high symetry lines in
    the first brillouin zone.

anaStruct.py
    Make histograms of distances and angles between atoms in a crystal
    structure read from a POSCAR/CONTCAR VASP file.

bands_Cu.py
    Build a band diagram with s, p, d contribution mapped on a RGB color scale.
    This script use pymatgen.

vacantPosition.py
    Load a structure and look for vacant positions using a grid. For each point
    of the grid the neighbors list is built in order to accept the position.

encut.job
    Bash script to compute gamma point energie as a function of the plane waves cutoff.

chgsum.f90
    Fortran program in order to sum up two CHGCAR files. This fortran program is
    at least two times faster than a python script.

chgsplit.f90
    Fortran program in order to split a CHGCAR file into a first CHGCAR file
    containing only the spin up density and one other containing only spin down
    density.

makeCL.py / readCL.py
    Python scripts in order to setup a series of corelevel calculations and read the
    results.

bandstructure.py
    Python script which relies on pymatgen in order to plot band structure
    diagram.

kpoints.job / ana_kpoints.py (and kspacing)
    Bash and python scripts in order to run VASP calculations for a series of k-points
    grid using either a cubic grid or using KSPACING VASP keywords. The python script
    export the results.

encut.job
    Bash script to run a series of VASP calculations for various ENCUT values.

runU.py / readU.py
    Python scripts in order to run and extract data from a series of VASP calculations for
    various U values (DFT+U formalism).



