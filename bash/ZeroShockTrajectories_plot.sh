#! /bin/bash

actiontime=1
epsilonarraypost=(0.1) 
python_name_unit="ZeroShockTrajectories_plot.py"
python_dir="/home/bcheng4/TwoCapital_Shrink/abatement_UD"
output_dir="/scratch/bincheng/"
NUM_DAMAGE=20

declare -A hXarr1=([0]=0.2 [1]=0.2 [2]=0.2)
declare -A hXarr2=([0]=0.1 [1]=0.1 [2]=0.1)
# hXarrays=(hXarr1)
hXarrays=(hXarr2)


Xminarr=(4.00 0.0 1.0 0.0)
Xmaxarr=(9.00 4.0 6.0 3.0)



# xi_a=(100000. 100000. 100000.)
# xi_k=(0.025  0.050 100000.)
# xi_c=(0.025  0.050 100000.)
# xi_j=(0.025  0.050 100000.)
# xi_d=(0.025  0.050 100000.)
# xi_g=(0.025  0.050 100000.)


# xi_a=(100000. 100000. 100000.)
# xi_k=(0.075  0.150 100000.)
# xi_c=(0.075  0.150 100000.)
# xi_j=(0.075  0.150 100000.)
# xi_d=(0.075  0.150 100000.)
# xi_g=(0.075  0.150 100000.)


# xi_a=(100000. 100000. 100000. 100000.)
# xi_k=(100000. 100000. 0.075 100000.)
# xi_c=(0.075 100000. 100000. 100000.)
# xi_j=(100000. 100000. 100000. 0.075)
# xi_d=(100000. 0.075 100000. 100000.)
# xi_g=(100000. 100000. 100000. 0.075)

# xi_a=(100000. 100000. 100000. 100000.)
# xi_k=(100000. 100000. 0.150   100000.)
# xi_c=(0.150 100000. 100000. 100000.)
# xi_j=(100000. 100000. 100000. 0.150)
# xi_d=(100000. 0.150 100000. 100000.)
# xi_g=(100000. 100000. 100000. 0.150)


varrhoarr=(1120)
psi0arr=(0.105830)
psi1arr=(0.5)



# phi0arr=(0.1 0.5)
phi0arr=(0.5)
# phi0arr=(0.1)
LENGTH_phi0=$((${#phi0arr[@]} - 1))


# rhoarr=(0.66 1 1.5)
# deltaarr=(0.015 0.010 0.010)


rhoarr=(1)
deltaarr=(0.010)

LENGTH_rho=$((${#rhoarr[@]} - 1))




server_name="mercury"

LENGTH_psi=$((${#psi0arr[@]} - 1))
LENGTH_xi=$((${#xi_a[@]} - 1))

hXarr_SG=(0.2 0.2 0.2)
Xminarr_SG=(4.00 0.0 -5.5 0.0)
Xmaxarr_SG=(9.00 4.0 0.0 3.0)
interp_action_name="2jump_step_0.2_0.2_0.2_LR_0.01"
fstr_SG="NearestNDInterpolator"

auto=1
# year=25
year=40
# year=130
# year=6000



plot_year_gamma=0
plot_year_theta=0

scheme_array=("direct")
HJBsolution_array=("direct")
LENGTH_scheme=$((${#scheme_array[@]} - 1))




for epsilonpost in ${epsilonarraypost[@]}; do
    for hXarri in "${hXarrays[@]}"; do
        for phi0index in $(seq 0 $LENGTH_phi0); do

        count=0
        declare -n hXarr="$hXarri"

        action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilonpost}_Current_phi0_${phi0arr[$phi0index]}"


        for PSI_0 in ${psi0arr[@]}; do
            for PSI_1 in ${psi1arr[@]}; do
					for varrho in ${varrhoarr[@]}; do
                        for k in $(seq 0 $LENGTH_scheme); do
                        for kk in $(seq 0 $LENGTH_rho); do

                    mkdir -p ./job-outs/${action_name}/Graph_Plot/scheme_${scheme_array[$k]}_HJB_${HJBsolution_array[$k]}/PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}/

                    if [ -f ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}_Graph.sh ]; then
                        rm ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}_Graph.sh
                    fi
                    mkdir -p ./bash/${action_name}/

                    touch ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}_Graph.sh

                    tee -a ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}_Graph.sh <<EOF
#! /bin/bash


######## login 
#SBATCH --job-name=graph_combine
#SBATCH --output=./job-outs/${action_name}/Graph_Plot/scheme_${scheme_array[$k]}_HJB_${HJBsolution_array[$k]}/PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}/graph_${HJBsolution_array[$k]}_${python_name_unit}.out
#SBATCH --error=./job-outs/${action_name}/Graph_Plot/scheme_${scheme_array[$k]}_HJB_${HJBsolution_array[$k]}/PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}/graph_${HJBsolution_array[$k]}_${python_name_unit}.err

#SBATCH --account=pi-lhansen
#SBATCH --partition=standard
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=7-00:00:00
#SBATCH --exclude=mcn59

####### load modules
module load python/booth/3.8  gcc/9.2.0


echo "\$SLURM_JOB_NAME"
echo "Program starts \$(date)"
start_time=\$(date +%s)

python3 ${python_dir}/${python_name_unit} --dataname  ${action_name}  --outputname ${output_dir} --pdfname ${server_name} --psi0 ${PSI_0} --psi1 ${PSI_1}  --xiaarr ${xi_a[@]} --xikarr ${xi_k[@]}  --xicarr ${xi_c[@]}  --xijarr ${xi_j[@]} --xidarr ${xi_d[@]} --xigarr ${xi_g[@]}  --hXarr ${hXarr[@]} --Xminarr ${Xminarr[@]} --Xmaxarr ${Xmaxarr[@]} --auto $auto --IntPeriod ${year} --num_gamma ${NUM_DAMAGE} --scheme ${scheme_array[$k]}  --HJB_solution ${HJBsolution_array[$k]}  --varrho ${varrho}   --phi_0 ${phi0arr[$phi0index]}   --rho ${rhoarr[$kk]} --delta ${deltaarr[$kk]} --plot_year_gamma ${plot_year_gamma}  --plot_year_theta ${plot_year_theta}

echo "Program ends \$(date)"
end_time=\$(date +%s)

# elapsed time with second resolution
elapsed=\$((end_time - start_time))

eval "echo Elapsed time: \$(date -ud "@\$elapsed" +'\$((%s/3600/24)) days %H hr %M min %S sec')"

EOF

                    sbatch ./bash/${action_name}/hX_${hXarr[0]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$kk]}_delta_${deltaarr[$kk]}_Graph.sh

                    done
                done
            done
        done
    done
done
done
done