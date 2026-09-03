* Merit Order Model (Basic)

Sets
t time /timestep1*timestep6/
i generation technologies / lignite, gas_1, gas_2, combinedCycle, nuclear,
                            runOfRiver, hardcoal_1, hardcoal_2, biomass/
;

Parameters
D(t) demand (load)
         / timestep1 3000
           timestep2 3500
           timestep3 4200
           timestep4 3900
           timestep5 4000
           timestep6 3600 /

y_max(i) capacity generation technologies (limit)
        / lignite        800
          gas_1          200
          gas_2          150
          combinedCycle  700
          nuclear       1000
          runOfRiver      50
          hardcoal_1     750
          hardcoal_2     650
          biomass         20  /

c_var(i)  variable costs of each power plant
        / lignite        38.5
          gas_1          61.5
          gas_2          80
          combinedCycle  42.86
          nuclear        6.06
          runOfRiver      0
          hardcoal_1     52.15
          hardcoal_2     62.61
          biomass        66.82 /
;

Scalar
dt duration of planning time intervals (h) /4/
;

free variables
C_op        Sum of operational costs (value of objective funstion)
;

positive variables
y(i,t)       output of power plant
;

Equations
objfunc      objective function (minimize total variable costs)
loadserve(t) load serving
maxcap(i,t)  maximum capacity limit
;

objfunc..        C_op =e= sum((i,t), c_var(i) * y(i,t)* dt);
loadserve(t)..   sum(i, y(i,t))* dt =e= D(t) * dt;
maxcap(i,t)..    y(i,t) =l= y_max(i);

Model merit_order   /all/;

Solve merit_order using LP minimizing C_op;

* Write gdx-file (containing all sets, parameters, variables, equations)
execute_unload 'results_unitcommitment.gdx'

* Write values to excel
execute 'gdxxrw.exe results_unitcommitment.gdx var=y.l      rng=Gen!';
execute 'gdxxrw.exe results_unitcommitment.gdx equ=loadserve.m      rng=Prices!';