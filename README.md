# Age-Aware-Remote-MDP
This paper uses age of information as side information to facilitate goal-oriented remote decision making. This repository contains the code for our paper in IEEE Information Workshop 2024: [Sampling to Achieve the Goal: An Age-Aware Remote Markov Decision Process](https://arxiv.org/pdf/2405.02042v3).

## Algorithm 1: Bisec-MRVI
The Bisec-MRVI folder contains the code for Algorithm 1 in our paper.

| Files              | Description                                                                         |
| ------------------ | ----------------------------------------------------------------------------------- |
| MRVI_Bisec_Main.m  | The main file. You can run this file directly to reproduce our result.              |
| MRVI.m             | The inner layer MRVI algorithm. This function outputs the optimal value of the MDP. |
| Qfunction_MRVI.m   | This function outputs the modified Q-function in the Value Update process.          |
| ValueUpdate_MRVI.m | The function accomplishes the value update process in MRVI.                         |  

## Algorithm 2: FPBI
The FPBI folder contains the code for Algorithm 2 in our paper.

| Files                  | Description                                                                                                                                                                                                   |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FPBI_Main.m            | The main file. You can run this file directly to reproduce our result.                                                                                                                                        |
| AoI_threshold.m        | This algorithm reproduces the AoI-optimal policy proposed in Theorem 3 of [Sampling for Data Freshness Optimization: Non-linear Age Functions](https://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=8764465). |
| hstar.m                | This function implements the fixed point iteration on h.                                                                                                                                                      |
| hstar_AoI.m            | This function implements the fixed point iteration for h under AoI-optimal sampling.                                                                                                                          |
| hstar_Zerowait.m       | This function implements the fixed point iteration for h under zero-wait sampling.                                                                                                                            |
| Qfunction.m            | This function outputs the Q-function in the Value Update process.                                                                                                                                             |
| ValueUpdate.m          | This function implements the fixed point iteration on W.                                                                                                                                                      |
| ValueUpdate_AoI.m      | This function implements the fixed point iteration on W under AoI-optimal sampling.                                                                                                                           |
| ValueUpdate_Zerowait.m | This function implements the fixed point iteration on W under zero-wait sampling.                                                                                                                             |
| Transitionfunction.m     | This function describes the transformed transition probability.

## Contact
If you encounter any issues with reproduction, feel free to reach out to me at [hitliaimin@163.com](mailto:hitliaimin@163.com).

## Citation
You may cite this paper if it helps your research:
```
@inproceedings{li2024sampling,
		author       = {Aimin Li and Shaohua Wu and Gary C. F. Lee and Xiaomeng Chen and Sumei Sun},
		title        = {Sampling to Achieve the Goal: An Age-aware Remote Markov Decision Process},
		booktitle    = {Proc. {IEEE} {ITW}},
		pages        = {121-126},
		year         = {2024},
}
```
