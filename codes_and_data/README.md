# Part 1. Code that produces simulation results

bls

    1. mainBAU.m – is the main file that calculates the BAU transition path with different damage sensitivity levels controlled by the parameter **kplus**. When **kplus** equals 0.001, it corresponds to the 1x Damages case; for **kplus** equal to 0.002, it represents the 2x Damages case; with **kplus** set to 0.004, it corresponds to the 4x Damages case; and when **kplus** is 0.006, it represents the 6x Damages case. The results of the computation are saved in a file named **BAU1x.mat**.
    
    2. regionspopulation18part1; regionspopulation18part2 – contain data for calibrating population dynamics
    
    3. workingonsteadystate.m – is a program for finding the steady state of the model.
    
    4. fun.m - is an auxiliary function that is always equal to one.
    
    5. nontradablesolvefminconsteady.m - is a function that contains nonlinear equations describing the supply-side of the steady state.
    
    6. gradientnontradablesolvefminconsteady.m – is a file that contains a gradient for this function
    
    7. hessianfcnsteady.m and hessiannontradablesolvefminconsteady.m – are a function and an auxiliary file for constructing the hessian to solve the nonlinear equations 
    describing the supply-side of the steady state.
    
    8. Initialassets.m – contains data on distribution of initial assets
    
    9. nontradableiterationsfmincon.m – a program that performs time-inverse iterations, solving a nonlinear system of equations for supply-side for each time point
    
    10. nontradablesolvefmincon.m - is a function that contains nonlinear equations describing the supply-side in the dirty-energy usage regime.
    
    11. gradientnontradablesolvefmincon.m – is a file that contain a gradient for this function
    
    12. hessianfcn.m and hessiannontradablesolvefmincon.m – are a function and an auxiliary file for constructing the hessian to solve the nonlinear equations describing the 
    supply-side in the dirty-energy usage regime
    
    13. updatehouseholdandclimate.m – is a program for updating climate variables, damages and household variables
    
    14. temp_region_W_- files  link regional temperatures with the global temperature.
    
    15. computeSCC.m– is a program that calculates the discounted marginal damages from carbon dioxide emissions.
    
    16. mainPolicy.m - is a program that finds the equilibrium in the model with no transfers and a certain tax path. In the replication package, the tax path is set based on the SCC calculated in the BAU equilibrium. Any tax path can be specified here within reasonable limits, including delayed tax. The program loads the BAU1x.mat file and saves the results in the Policy1x.mat file.
    
    17. updatehouseholdandclimatePolicy.m - is a program for updating climate, damage, and household variables in Policy scenarios.
    
    18. nontradableiterationsfminconPolicy.m - a program that performs time iterations, solving a nonlinear system of equations for supply-side for each time point for the policy regime
    
___

    19. LSRA.m – is a program for finding LSRA solution with prespecified tax path (including delayed tax). The code allows to specify various options for allocating benefits from taxing emissions, and also introduces a limit on the maximum possible tax (regulated by **TaxCap**)
    
    20. mainOptimalPolicy – is a program for finding the optimal tax, which is iterated between programs computeSCC.m and LSRA.m
    
    21. gradientnontradablesolvefmincon2level.m, hessianfcn2level.m, hessiannontradablesolvefmincon2level.m, nontradablesolvefmincon2level.m - these are analogs to the functions mentioned earlier 10-12, only implementing the model specification with a two-level CES. Replacing these functions in the corresponding parts of the code should allow to solve the model with a two-level CES function.
___    
    
# Part 2. Code that produces figures
    Figure 1 – Simon
Figure 2 - PlotFigure2.m
Figure 3 – Simon
Figure 4 – PlotFigure4.m
Figure 5 – PlotFigure5.m
Figure 6 – PlotFigure6.m
Figure 7 – PlotFigure7.m
Figure 8 – PlotFigure8.m
Figure 9 – PlotFigure9.m
Figure 10 – PlotFigure10.m
Figure 11 – PlotFigure11.m
Figure 12 – PlotFigure12.m
Figure 13 – PlotFigure13.m
Figure 14 – PlotFigure14.m
Figure 15 – PlotFigure15.m
Figure 16 – PlotFigure16.m    

# Part 3. Code that produces tables
       Tables 1-4 and 8 contain region definitions and calibration data used
       Table 5 – MakeTable5.m
       Table 6 – MakeTable6.m
       Table 7 – MakeTable7.m
       Table 9 and 10 – MakeTable9and10.m

