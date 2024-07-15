# Part 1: Codes to replication the simulation results of the article

## Business as usual (BAU) results

Running `mainBAU.m' in MATLAB will calclate the BAU transition path with different damage sensitivity levels controlled by the parameter **kplus**. When **kplus** equals 0.001, it corresponds to the 1x Damages case; for **kplus** equal to 0.002, it represents the 2x Damages case; with **kplus** set to 0.004, it corresponds to the 4x Damages case; and when **kplus** is 0.006, it represents the 6x Damages case. The results of the computation are saved in a file named **BAU1x.mat**.

### Files required to run `mainBAU.m'

    1. `mainBAU'.m'
    
    2. `regionspopulation18part1'; `regionspopulation18part2': contain data for calibrating population dynamics.
    
    3. `workingonsteadystate.m': a program for finding the steady state of the model.
    
    4. `fun.m': auxiliary function that is always equal to one.
    
    5. `nontradablesolvefminconsteady.m': function that contains nonlinear equations describing the supply-side of the steady state.
    
    6. `gradientnontradablesolvefminconsteady.m': a file that contains a gradient for this function.
    
    7. `hessianfcnsteady.m'; `hessiannontradablesolvefminconsteady.m': a function and an auxiliary file for constructing the hessian to solve the nonlinear equations 
    describing the supply-side of the steady state.
    
    8. `Initialassets.m': contains data on distribution of initial assets
    
    9. `nontradableiterationsfmincon.m': a program that performs time-inverse iterations, solving a nonlinear system of equations for supply-side for each time point.
    
    10. `nontradablesolvefmincon.m': a function that contains nonlinear equations describing the supply-side in the dirty-energy usage regime.
    
    11. `gradientnontradablesolvefmincon.m': a file that contain a gradient for this function.
    
    12. `hessianfcn.m'; `hessiannontradablesolvefmincon.m': a function and an auxiliary file for constructing the hessian to solve the nonlinear equations describing the 
    supply-side in the dirty-energy usage regime.
    
    13. `updatehouseholdandclimate.m': a program for updating climate variables, damages and household variables.
    
    14. `temp_region_W_-* files': those files link regional temperatures with the global temperature.

## Programs to compute policy-related quantities

    15. `computeSCC.m': a program that calculates the discounted marginal damages from carbon dioxide emissions.
    
    16. `mainPolicy.m': a program that finds the equilibrium in the model with no transfers and a certain tax path. In the replication package, the tax path is set based on the SCC calculated in the BAU equilibrium. Any tax path can be specified here within reasonable limits, including delayed tax. The program loads the BAU1x.mat file and saves the results in the Policy1x.mat file.
    
    17. `updatehouseholdandclimatePolicy.m': a program for updating climate, damage, and household variables in Policy scenarios.
    
    18. `nontradableiterationsfminconPolicy.m': a program that performs time iterations, solving a nonlinear system of equations for supply-side for each time point for the policy regime.
    
## Programs to compute the Lump Sum Redistribution Authority (LSRA) solutions 

    19. `LSRA.m': a program for finding LSRA solution with prespecified tax path (including delayed tax). The code allows to specify various options for allocating benefits from taxing emissions, and also introduces a limit on the maximum possible tax (regulated by **TaxCap**).
    
    20. `mainOptimalPolicy': a program for finding the optimal tax, which is iterated between programs computeSCC.m and LSRA.m.
    
    21. `gradientnontradablesolvefmincon2level.m'; `hessianfcn2level.m'; `hessiannontradablesolvefmincon2level.m'; `nontradablesolvefmincon2level.m': these codes are analogs to the functions mentioned earlier 10-12, only implementing the model specification with a two-level CES. Replacing these functions in the corresponding parts of the code should allow to solve the model with a two-level CES function.

    
# Part 2: Codes that reproduce the figures of the article

The following MATLAB scripts replicate the figures in the article that are based in numerical calculations.

    * Figure 1 – Simon
    * Figure 2: run the script [PlotFigure2.m](PlotFigure2.m) 
    * Figure 3: – Simon
    * Figure 4: run the script [PlotFigure4.m](PlotFigure4.m)
    * Figure 5: run the script [PlotFigure5.m](PlotFigure5.m)
    * Figure 6: run the script [PlotFigure6.m](PlotFigure6.m)
    * Figure 7: run the script [PlotFigure7.m](PlotFigure7.m)
    * Figure 8: run the script [PlotFigure8.m](PlotFigure8.m)
    * Figure 9: run the script [PlotFigure9.m](PlotFigure9.m)
    * Figure 10: run the script [PlotFigure10.m](PlotFigure10.m)
    * Figure 11: run the script [PlotFigure11.m](PlotFigure11.m)
    * Figure 12: run the script [PlotFigure12.m](PlotFigure12.m)
    * Figure 13: run the script [PlotFigure13.m](PlotFigure13.m)
    * Figure 14: run the script [PlotFigure14.m](PlotFigure14.m)
    * Figure 15: run the script [PlotFigure15.m](PlotFigure15.m)
    * Figure 16: run the script [PlotFigure16.m](PlotFigure16.m)


# Part 3. Code that produces tables

The following MATLAB scripts replicate the figures in the article that are based in numerical calculations.

    * Table 5: run the script [MakeTable5.m](MakeTable5.m)
    * Table 6: run the script [MakeTable6.m](MakeTable6.m)
    * Table 7: run the script [MakeTable7.m](MakeTable7.m)
    * Tables 9 and 10: run the script [MakeTable9and10.m](MakeTable9and10.m)

Furthermore, note that tables 1-4, and 8 contain region definitions and calibration data used, and are publicly available.
