#! /bin/bash

epsilonarray=(0.1) 

python_name="Postdamage.py" 
python_dir="/home/bcheng4/TwoCapital_Shrink/abatement_UD"
output_dir="/scratch/bincheng/"
NUM_DAMAGE=20
ID_MAX_DAMAGE=$((NUM_DAMAGE - 1))

maxiterarr=(2000000 30000)

declare -A hXarr1=([0]=0.2 [1]=0.2 [2]=0.2)
declare -A hXarr2=([0]=0.1 [1]=0.1 [2]=0.1)
hXarrays=(hXarr1)
# hXarrays=(hXarr2)



Xminarr=(4.00 0.0 1.0 0.0)
Xmaxarr=(9.00 4.0 6.0 3.0)




# xi_a=(100000. 100000. 100000.)
# xi_k=(0.025  0.050 100000.)
# xi_c=(0.025  0.050 100000.)
# xi_j=(0.025  0.050 100000.)
# xi_d=(0.025  0.050 100000.)
# xi_g=(0.025  0.050 100000.)

xi_a=(100000. 100000. 100000.)
xi_k=(0.075  0.150 100000.)
xi_c=(0.075  0.150 100000.)
xi_j=(0.075  0.150 100000.)
xi_d=(0.075  0.150 100000.)
xi_g=(0.075  0.150 100000.)
	# More , less, neutrality

# table 3
# xi_a=(100000. 100000. 100000. 100000.)
# xi_k=(0.075 100000. 100000. 100000.)
# xi_c=(100000. 0.075 100000. 100000.)
# xi_j=(100000. 100000. 0.075 100000.)
# xi_d=(100000. 100000. 100000. 0.075)
# xi_g=(100000. 100000. 0.075 100000.)

# xi_a=(100000. 100000. 100000. 100000.)
# xi_k=(0.150 100000. 100000. 100000.)
# xi_c=(100000. 0.150 100000. 100000.)
# xi_j=(100000. 100000. 0.150 100000.)
# xi_d=(100000. 100000. 100000. 0.150)
# xi_g=(100000. 100000. 0.150 100000.)



# xi_a=(0.0027 0.0028 0.0029 0.0030 0.0031 0.0032 0.0033)
# xi_k=(0.150 0.150 0.150 0.150 0.150 0.150 0.150)
# xi_c=(100000. 100000. 100000. 100000. 100000. 100000. 100000.)
# xi_j=(0.150 0.150 0.150 0.150 0.150 0.150 0.150)
# xi_d=(0.150 0.150 0.150 0.150 0.150 0.150 0.150)
# xi_g=(0.150 0.150 0.150 0.150 0.150 0.150 0.150)

varrhoarr=(1120)

# rhoarr=(0.66 1 1.5)
# deltaarr=(0.010 0.010 0.010)

rhoarr=(1)
deltaarr=(0.010)


# rhoarr=(1 1 1)
# deltaarr=(0.010 0.020 0.030)



LENGTH_rho=$((${#rhoarr[@]} - 1))
psi0arr=(0.105830)

# phi0arr=(0.1 0.5)
phi0arr=(0.5)
# phi0arr=(0.1)
LENGTH_phi0=$((${#phi0arr[@]} - 1))

psi1arr=(0.5)
LENGTH_psi=$((${#psi0arr[@]} - 1))
LENGTH_xi=$((${#xi_a[@]} - 1))



for epsilon in ${epsilonarray[@]}; do
	for hXarri in "${hXarrays[@]}"; do
        for phi0index in $(seq 0 $LENGTH_phi0); do

		count=0
		declare -n hXarr="$hXarri"

		action_name="2jump_step_${Xminarr[0]},${Xmaxarr[0]}_${Xminarr[1]},${Xmaxarr[1]}_${Xminarr[2]},${Xmaxarr[2]}_${Xminarr[3]},${Xmaxarr[3]}_SS_${hXarr[0]},${hXarr[1]},${hXarr[2]}_LR_${epsilon}_Current_phi0_${phi0arr[$phi0index]}"


		
		epsilonarr=(0.1 ${epsilon})
		fractionarr=(0.1 ${epsilon})

		for i in $(seq 0 $ID_MAX_DAMAGE); do
			for PSI_0 in ${psi0arr[@]}; do
				for PSI_1 in ${psi1arr[@]}; do
					for varrho in ${varrhoarr[@]}; do
						for j in $(seq 0 $LENGTH_xi); do
							for k in $(seq 0 $LENGTH_rho); do

								mkdir -p ./job-outs/${action_name}/Post/xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}/

								if [ -f ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}_ID_${i}.sh ]; then
									rm ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}_ID_${i}.sh
								fi

								mkdir -p ./bash/${action_name}/

								touch ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}_ID_${i}.sh

								tee -a ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}_ID_${i}.sh <<EOF
#! /bin/bash

######## login
#SBATCH --job-name=${Xminarr[1]}_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_${rhoarr[$k]}_phi0_${phi0arr[$phi0index]}_${i}_${epsilon}
#SBATCH --output=./job-outs/${action_name}/Post/xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}/mercury_post_${i}_subs.out
#SBATCH --error=./job-outs/${action_name}/Post/xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}/mercury_post_${i}_subs.err

#SBATCH --account=pi-lhansen
#SBATCH --partition=standard
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=7-00:00:00
#SBATCH --exclude=mcn53,mcn55,mcn57,mcn08

####### load modules
module load python/booth/3.8  gcc/9.2.0

echo "\$SLURM_JOB_NAME"

echo "Program starts \$(date)"
start_time=\$(date +%s)
# perform a task

python3 ${python_dir}/$python_name  --outputname ${output_dir} --num_gamma $NUM_DAMAGE --xi_a ${xi_a[$j]} --xi_k ${xi_k[$j]} --xi_c ${xi_c[$j]} --xi_j ${xi_j[$j]}  --xi_d ${xi_d[$j]} --xi_g ${xi_g[$j]}  --epsilonarr ${epsilonarr[@]}  --fractionarr ${fractionarr[@]}   --maxiterarr ${maxiterarr[@]}  --id $i --psi_0 $PSI_0 --psi_1 $PSI_1 --name ${action_name} --hXarr ${hXarr[@]} --Xminarr ${Xminarr[@]} --Xmaxarr ${Xmaxarr[@]}  --varrho ${varrho}  --phi_0 ${phi0arr[$phi0index]}  --rho ${rhoarr[$k]} --delta ${deltaarr[$k]}

echo "Program ends \$(date)"
end_time=\$(date +%s)

# elapsed time with second resolution
elapsed=\$((end_time - start_time))

eval "echo Elapsed time: \$(date -ud "@\$elapsed" +'\$((%s/3600/24)) days %H hr %M min %S sec')"
# echo ${hXarr[@]}

EOF
									count=$(($count + 1))
									sbatch ./bash/${action_name}/hX_${hXarr[0]}_xia_${xi_a[$j]}_xik_${xi_k[$j]}_xic_${xi_c[$j]}_xij_${xi_j[$j]}_xid_${xi_d[$j]}_xig_${xi_g[$j]}_PSI0_${PSI_0}_PSI1_${PSI_1}_varrho_${varrho}_rho_${rhoarr[$k]}_delta_${deltaarr[$k]}_ID_${i}.sh
								done
							done
						done
					done
				done
			done
		done
	done
done
