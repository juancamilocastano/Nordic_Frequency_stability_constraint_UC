function build_ac_opf_acdc_Nordic!(m::Model)
    # This function is based on build_ac_opf_acdc_frequency_several_res_var_without_loss_res

    # Create m.ext entries "variables", "expressions" and "constraints"
    m.ext[:variables] = Dict()
    m.ext[:expressions] = Dict()
    m.ext[:constraints] = Dict()

    # Extract sets
    # AC network
    baseMVA = m.ext[:parameters][:baseMVA]
    N = m.ext[:sets][:N]
    N_sl = m.ext[:sets][:N_sl]
    N1=m.ext[:sets][:N1]
    N2=m.ext[:sets][:N2]
    B = m.ext[:sets][:B]
    B_ac_fr = m.ext[:sets][:B_ac_fr]
    B_ac_to = m.ext[:sets][:B_ac_to]
    G = m.ext[:sets][:G]
    G_ac = m.ext[:sets][:G_ac]
    G_solar = m.ext[:sets][:G_solar]
    G_wind = m.ext[:sets][:G_wind]
    L = m.ext[:sets][:L]
    L_ac = m.ext[:sets][:L_ac]
    #W_ac = m.ext[:sets][:W_ac]
    B_ac = m.ext[:sets][:B_ac]
    B_arcs = m.ext[:sets][:B_arcs]
    bus_ij = m.ext[:sets][:bus_ij]
    bus_ji = m.ext[:sets][:bus_ji]
    bus_ij_ji = m.ext[:sets][:bus_ij_ji]
    G_reservoir = m.ext[:sets][:G_reservoir]
    G_pump = m.ext[:sets][:G_pump]
    G_nuclear = m.ext[:sets][:G_nuclear]
    G_gas = m.ext[:sets][:G_gas]
    G_biomass = m.ext[:sets][:G_biomass]
    G_oil = m.ext[:sets][:G_oil]

    T= m.ext[:sets][:t]

    S = m.ext[:sets][:S]

    E= m.ext[:sets][:E]


    # Extract parameters
  
    f1 = m.ext[:parameters][:f1]

    deltaf = m.ext[:parameters][:deltaf]
         

    # AC network
    gen_bus = m.ext[:parameters][:gen_bus]
    load_bus = m.ext[:parameters][:load_bus]
    
    #shunt_bus = m.ext[:parameters][:shunt_bus]
    vmmin = m.ext[:parameters][:vmmin]
    vmmax = m.ext[:parameters][:vmmax]
    vamin = m.ext[:parameters][:vamin]
    vamax = m.ext[:parameters][:vamax]
    rb =  m.ext[:parameters][:rb]
    xb =  m.ext[:parameters][:xb] 
    gb =  m.ext[:parameters][:gb]
    bb =  m.ext[:parameters][:bb] 
    #gs =  m.ext[:parameters][:gs]
    #bs =  m.ext[:parameters][:bs] 
    gfr = m.ext[:parameters][:gb_sh_fr]
    bfr = m.ext[:parameters][:bb_sh_fr]
    gto = m.ext[:parameters][:gb_sh_to]
    bto = m.ext[:parameters][:bb_sh_to]
    pmaxbranch = m.ext[:parameters][:pmaxbranch]
    angmin = m.ext[:parameters][:angmin]
    angmax = m.ext[:parameters][:angmax]
    b_shift = m.ext[:parameters][:b_shift]
    b_tap = m.ext[:parameters][:b_tap]
    pd = m.ext[:parameters][:pd]
    qd = m.ext[:parameters][:qd]
    pmax = m.ext[:parameters][:pmax]
    pmin = m.ext[:parameters][:pmin]
    #qmax = m.ext[:parameters][:qmax]
    #qmin = m.ext[:parameters][:qmin]
    gen_cost = m.ext[:parameters][:gen_cost]
    ij_ji_ang_max = m.ext[:parameters][:ij_ji_ang_max]
    ij_ji_ang_min = m.ext[:parameters][:ij_ji_ang_min]
    demand = m.ext[:parameters][:demand]
    d= m.ext[:parameters][:d]
    wind_per_node= m.ext[:parameters][:wind_per_node]
    #total_wind= m.ext[:parameters][:total_wind]
    capacity_factor_solar= m.ext[:parameters][:capacity_factor_solar]
    capacity_factor_wind= m.ext[:parameters][:capacity_factor_wind]
    upramp = m.ext[:parameters][:upramp]
    downramp = m.ext[:parameters][:downramp]
    MUT = m.ext[:parameters][:MUT]
    MDT = m.ext[:parameters][:MDT]
    G_reservecost=m.ext[:parameters][:G_reservecost]
    G_dt=m.ext[:parameters][:G_dt]
    ic=m.ext[:parameters][:ic]
    G_storage=m.ext[:parameters][:G_storage]
    MaxFreqDev=m.ext[:parameters][:MaxFreqDev]
    P_pump=m.ext[:parameters][:P_pump]
    G_npumping=m.ext[:parameters][:G_npumping]
    G_ngenerating=m.ext[:parameters][:G_ngenerating] 
    E_reservoirs_min=m.ext[:parameters][:E_reservoirs_min]
    E_reservoirs_ini=m.ext[:parameters][:E_reservoirs_ini]
    E_reservoirs_end=m.ext[:parameters][:E_reservoirs_end]
 

    # Electrolyzer
    Epmax = m.ext[:parameters][:Epmax]
    Epmin = m.ext[:parameters][:Epmin]
    Eefficiency = m.ext[:parameters][:Eefficiency]
    Eloadfactor = m.ext[:parameters][:Eloadfactor] 
    Eflowmax = m.ext[:parameters][:Eflowmax]
    Estoragemax = m.ext[:parameters][:Estoragemax]
    Estoragemin = m.ext[:parameters][:Estoragemin]
    Estorageinitial = m.ext[:parameters][:Estorageinitial]
    Estorageend = m.ext[:parameters][:Estorageend]
    Edeployment = m.ext[:parameters][:Edeployment]
    Ereservecost = m.ext[:parameters][:Ereservecost]
    Eeficiencycarga = m.ext[:parameters][:Eeficiencycarga]
    Eeficiencydischarge = m.ext[:parameters][:Eeficiencydischarge]
    Estartupcost = m.ext[:parameters][:Estartupcost]
    Ecompressorpower = m.ext[:parameters][:Ecompressorpower]
    electrolyzer_bus = m.ext[:parameters][:electrolyzer_bus]
    Hydrogencost = m.ext[:parameters][:Hydrogencost]
    baseKG = m.ext[:parameters][:baseKG]
    

    #storage
    Spmax = m.ext[:parameters][:Spmax]
    Sstoragemax = m.ext[:parameters][:Sstoragemax]
    Sdod = m.ext[:parameters][:Sdod]
    Sefficiencycarga = m.ext[:parameters][:Sefficiencycarga]
    Sefficiencydischarge = m.ext[:parameters][:Sefficiencydischarge]
    Senergyinitial = m.ext[:parameters][:Senergyinitial]
    Senergyend = m.ext[:parameters][:Senergyend]
    Sdeployment = m.ext[:parameters][:Sdeployment]
    Sreservecost = m.ext[:parameters][:Sreservecost]
    storage_bus = m.ext[:parameters][:storage_bus]


    all_contingencies = m.ext[:sets][:all_contingencies]
    TG=vcat(G_nuclear, G_gas, G_biomass, G_oil) #Thermal generation




#va = m.ext[:variables][:va] = @variable(m, [i=N,t=T], lower_bound = vamin[i], upper_bound = vamax[i], base_name = "va") # voltage angle

    # Thermal and hydro generation variables
    pg = m.ext[:variables][:pg] = @variable(m, [g=G,t=T],lower_bound=0, base_name = "pg") # active power generation
    rg_lg1 = m.ext[:variables][:rg_lg1] = @variable(m, [g=G,t=T],lower_bound=0, base_name = "rg_lg1") # frequency reserve generators loss of generation area 1
    

    # Status variable thermal generators
    zg = m.ext[:variables][:zg] = @variable(m, [g=G,t=T],binary= true , base_name = "zg") # status variable generator
    betag = m.ext[:variables][:betag] = @variable(m, [g=TG,t=T], binary= true, base_name = "betag") #
    gammag = m.ext[:variables][:gammag] = @variable(m, [g=TG,t=T], binary= true, base_name = "gammag") #
    δg= m.ext[:variables][:δg] = @variable(m, [g=G,t=T], binary=true, base_name="δg") #Binary variable event generator

    #Reservoir storage variables
    e_reservoir = m.ext[:variables][:e_reservoir] = @variable(m, [g=G_reservoir,t=T], lower_bound=0, upper_bound=G_storage[g], base_name = "e_reservoir") # energy storage reservoir
     #Pump generators variables
    p_charge_pump = m.ext[:variables][:p_charge_pump] = @variable(m, [g=G_pump,t=T], base_name = "p_charge_pump")
    e_pump = m.ext[:variables][:e_pump] = @variable(m, [g=G_pump,t=T], lower_bound=0, upper_bound=G_storage[g], base_name = "e_pump") # energy storage pump
   

    # Electrolyzer variables
    pe= m.ext[:variables][:pe] = @variable(m, [e=E,t=T], lower_bound=0, upper_bound=Epmax[e], base_name="pe") # Electrolyzer power consumption
    pe_compressor= m.ext[:variables][:pe_compressor] = @variable(m, [e=E,t=T], lower_bound=0, base_name="pe_compressor") # Electrolyzer power consumption for compressor
    pes= m.ext[:variables][:pes] = @variable(m, [e=E,t=T], lower_bound=0, base_name="pes") # Electrolyzer reserve power
    hfe= m.ext[:variables][:hfe] = @variable(m, [e=E,t=T], lower_bound=0, upper_bound=Eflowmax[e], base_name="hfe") # Electrolyzer hydrogen flow
    hfginyect= m.ext[:variables][:hfginyect] = @variable(m, [e=E,t=T], lower_bound=0, upper_bound=Eflowmax[e], base_name="hfginyect") # Electrolyzer hydrogen flow injected to the hydrogen grid
    hfgconsum= m.ext[:variables][:hfgconsum] = @variable(m, [e=E,t=T], lower_bound=0, upper_bound=Eflowmax[e], base_name="hfgconsum") # Electrolyzer hydrogen flow consumed from the hydrogen grid
    hss= m.ext[:variables][:hss] = @variable(m, [e=E,t=T], lower_bound=Estoragemin[e], upper_bound=Estoragemax[e], base_name="hss") # Electrolyzer storage level
    ze= m.ext[:variables][:ze] = @variable(m, [e=E,t=T], binary=true, base_name="ze") # Electrolyzer status
    zesu= m.ext[:variables][:zesu] =@variable(m, [e=E,t=T], binary=true, base_name="zesu") #Electrolyzer start up 
    zestb= m.ext[:variables][:zestb] = @variable(m, [e=E,t=T], binary=true, base_name="zestb") #Electrolyzer stanby indicator
    re_lg1=  m.ext[:variables][:re_lg1] = @variable(m, [e=E,t=T], lower_bound=0, base_name="re_lg1") #frequency reserve electrolyzers loss of generation area 1
    
    # Batteries variables
    psc = m.ext[:variables][:psc] = @variable(m, [s=S,t=T],lower_bound=0, base_name="psc") #Charging power of the batteries
    psd = m.ext[:variables][:psd] = @variable(m, [s=S,t=T],lower_bound=0, base_name="psd") #Discharging power of the batteries
    es = m.ext[:variables][:es] = @variable(m, [s=S,t=T], lower_bound= Sstoragemax[s]*(1-(Sdod[s]-0.041)), upper_bound=Sstoragemax[s] , base_name="es") #Energy bounds of the batteries
    zs = m.ext[:variables][:zs] = @variable(m, [s=S,t=T], binary=true, base_name="zb") #standby indicator of the batteries
    rs_lg1=  m.ext[:variables][:rs_lg1] = @variable(m, [s=S,t=T], lower_bound=0, base_name="rs_lg1") #frequency reserve batteries loss of generation area 1
   

    # Frequency stability variables
    plg1= m.ext[:variables][:plg1] = @variable(m, [t=T], lower_bound=0, base_name="plg1") # loss of power generators area 1
   
    #Auxiliary variables for rotated second order cone constraints
    ypg1 = m.ext[:variables][:ypg1] = @variable(m, [t=T],lower_bound=0, base_name="ypg1") #Auxiliary variable rotate second order cone generators fault area 1
    zpg1 = m.ext[:variables][:zpg1] = @variable(m, [t=T],lower_bound=0, base_name="zpg1") #Auxiliary variable rotate second order cone generators fault area 1
    

    # Other variables
    #rcu=m.ext[:variables][:rcu]=@variable(m,[t=T],lower_bound=0, upper_bound=total_wind["Nordic"][t], base_name="rcu") #Renewable curtailment
 
    
    #Second stage variables
    
    keys_contingency = collect(keys(all_contingencies))

    

    ##### Objective
    max_gen_ncost = m.ext[:parameters][:gen_max_ncost]
    if max_gen_ncost == 1
        m.ext[:objective] = @objective(m, Min,
                sum(gen_cost[g][1]
                        for g in G)
                            +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Ereservecost[e]*re_lg1[e,t] for e in E, t in T)*baseMVA
                            +sum(Sreservecost[s]*rs_lg1[s,t] for s in S, t in T)*baseMVA
                            +sum(G_reservecost[g]*rg_lg1[g,t] for g in G, t in T)*baseMVA
                           
                            

        )
    elseif max_gen_ncost == 2
       m.ext[:objective] = @objective(m, Min,
            sum(gen_cost[g][1] * pg[g, t] + gen_cost[g][2] 
                    for g in G, t in T)
                        +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Ereservecost[e]*re_lg1[e,t] for e in E, t in T)*baseMVA
                            +sum(Sreservecost[s]*rs_lg1[s,t] for s in S, t in T)*baseMVA
                            +sum(G_reservecost[g]*rg_lg1[g,t] for g in G, t in T)*baseMVA
                         
                            
        )
    elseif max_gen_ncost == 3
        m.ext[:objective] = @NLobjective(m, Min,
                sum(gen_cost[g][1]*pg[g,t]^2 + gen_cost[g][2]*pg[g,t] + gen_cost[g][3]
                        for g in G, t in T)
                            +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Ereservecost[e]*re_lg1[e,t] for e in E, t in T)*baseMVA
                            +sum(Sreservecost[s]*rs_lg1[s,t] for s in S, t in T)*baseMVA
                            +sum(G_reservecost[g]*rg_lg1[g,t] for g in G, t in T)*baseMVA 
                                    
        )   
    elseif max_gen_ncost == 4
        m.ext[:objective] = @NLobjective(m, Min,
                sum(gen_cost[g][1]*pg[g,t]^3 + gen_cost[g][2]*pg[g,t]^2 + gen_cost[g][3]*pg[g,t] + gen_cost[g][4]
                        for g in G, t in T)+sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                             +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Hydrogencost[e]*baseKG*(-hfginyect[e,t]+hfgconsum[e,t]) for e in E, t in T)
                            +sum(Ereservecost[e]*re_lg1[e,t] for e in E, t in T)*baseMVA
                            +sum(Sreservecost[s]*rs_lg1[s,t] for s in S, t in T)*baseMVA
                            +sum(G_reservecost[g]*rg_lg1[g,t] for g in G, t in T)*baseMVA
                        
        )
    end


 #Nodal power balance constraint AC taken from https://github.com/Electa-Git/OPES/blob/main/opf_acdc/build_ac_opf_acdc_tap.jl line 421
        m.ext[:constraints][:power_balance] = @constraint(m, [t=T],
        sum(pg[g,t] for g in TG )+sum(pg[g,t] for g in G_reservoir)+sum(pg[g,t] for g in G_pump)+sum(pg[g,t] for g in G_solar)+sum(pg[g,t] for g in G_wind)-sum(p_charge_pump[g,t] for g in G_pump)-sum(d["$n"][t] for n in keys(d))+sum(psd[s,t] for s in S )-sum(psc[s,t] for s in S ) -sum(pe[e,t] for e in E ) -sum(pe_compressor[e,t] for e in E )== 0 #3.7
        )




#Solar generation constraint
    m.ext[:constraints][:solar_generation] = @constraint(m, [g=G_solar,t=T],
        pg[g,t] <= capacity_factor_solar["Nordic"][t]*pmax[g]
    )
    m.ext[:constraints][:solar_reserve] = @constraint(m, [g=G_solar,t=T],
        rg_lg1[g,t] == 0
    )

    #wind gneration constraint
    m.ext[:constraints][:wind_generation] = @constraint(m, [g=G_wind,t=T],
        pg[g,t] <= capacity_factor_wind["Nordic"][t]*pmax[g]
    )
    m.ext[:constraints][:wind_reserve] = @constraint(m, [g=G_wind,t=T],
        rg_lg1[g,t]==0
    )

    m.ext[:constraints][:max_gen_power_TG] = @constraint(m, [g=TG,t=T],
        pg[g,t]+rg_lg1[g,t] <= pmax[g]*zg[g,t]
        )#3.11

    m.ext[:constraints][:min_gen_power_TG] = @constraint(m, [g=TG,t=T],
        pg[g,t]>= pmin[g]*zg[g,t]
        )#3.11

    m.ext[:constraints][:max_frequency_reserve_constraint] = @constraint(m, [g=TG,t=T],
        rg_lg1[g,t] <= MaxFreqDev[g]*zg[g,t]
        )#3.18


    Tlabels = collect(T)         # ensure indexable by position
    NT = length(Tlabels)      

    #Unit commitment constraints


    #Ramp-up limit for generators
        m.ext[:constraints][:up_and_down_2_a] = @constraint(m, [g in TG, k in 2:NT],
        pg[g, Tlabels[k]] - pg[g, Tlabels[k-1]] <= upramp[g]+(pmin[g]- upramp[g])*betag[g, Tlabels[k]]
    )#3.19

 
    #Ramp-down limit for generators
          m.ext[:constraints][:up_and_down_2_b] = @constraint(m, [g in TG, k in 2:NT],
        pg[g, Tlabels[k-1]] - pg[g, Tlabels[k]] <= downramp[g]+pmin[g]*gammag[g, Tlabels[k]]
    )#3.20

 
  #Initial status generators (unit commitment)
        m.ext[:constraints][:up_and_down_3] = @constraint(m, [g in TG],
        1 - zg[g, Tlabels[1]] + betag[g, Tlabels[1]] - gammag[g, Tlabels[1]] == 0
    )

    #Status generators (unit commitment)
        m.ext[:constraints][:up_and_down_4] = @constraint(m, [g in TG, k in 2:NT],
        zg[g, Tlabels[k-1]] - zg[g, Tlabels[k]] + betag[g, Tlabels[k]] - gammag[g, Tlabels[k]] == 0
    )#3.23

    #Startup and shutdown exclusivity
        m.ext[:constraints][:up_and_down_4_1] = @constraint(m, [g=TG, t=T],
        betag[g,t] + gammag[g,t] <= 1
    )

    #Minimum up time constraint
        m.ext[:constraints][:up_and_down_6] = Dict()
        for g in TG
            if MUT[g] > 0  # Only proceed if MUT[g] is positive
                for k in MUT[g]:NT
                    m.ext[:constraints][:up_and_down_6][g, Tlabels[k]] = @constraint(m,
                    zg[g, Tlabels[k]] >= sum(betag[g, Tlabels[k-τ]] for τ in 0:MUT[g]-1)#3.22
                    )
                end
            end
        end
        



    #Minimum down time constraint
    m.ext[:constraints][:up_and_down_7] = Dict()
    for g in TG
        if MDT[g] > 0  # Only proceed if MDT[g] is positive
            for k in MDT[g]:NT
                m.ext[:constraints][:up_and_down_7][g, Tlabels[k]] = @constraint(m,
                1 - zg[g, Tlabels[k]] >= sum(gammag[g, Tlabels[k-τ]] for τ in 0:MDT[g]-1)#3.21
                )
            end
        end
    end

# #Storage constraints Batteries

    m.ext[:constraints][:upper_bound_storage_charging] = @constraint(m, [s = S, t = T],
    psc[s,t] <= Spmax[s] * (1 - zs[s,t])
    )#3.25

    m.ext[:constraints][:upper_bound_storage_discharging] = @constraint(m, [s = S, t = T],
    psd[s,t] <= Spmax[s] * zs[s,t]
    )#3.26


        # Initial energy value of the batteries
        m.ext[:constraints][:initial_energy_value] = @constraint(m, [s in S],
            es[s, Tlabels[1]] == Senergyinitial[s]
        )#3.27


        # End energy value of the batteries
        
        m.ext[:constraints][:end_energy_value] = @constraint(m, [s in S],
            Senergyend[s] - es[s, Tlabels[NT]] ==
                Sefficiencycarga[s] * psc[s, Tlabels[NT]] -
                psd[s, Tlabels[NT]] / Sefficiencydischarge[s]
        )#3.27

        # Charging–discharging energy balance of the batteries
        m.ext[:constraints][:energy_balance] = @constraint(m, [s in S, k in 1:NT-1],
        es[s, Tlabels[k+1]] - es[s, Tlabels[k]] ==
            Sefficiencycarga[s] * psc[s, Tlabels[k]] -
            psd[s, Tlabels[k]] / Sefficiencydischarge[s]
    )#3.27

#Storage constraints Pump

    #Costraint reserve Pump
    m.ext[:constraints][:reserve_pump] = @constraint(m, [g in G_pump, t in T],
    rg_lg1[g,t] <= MaxFreqDev[g]*zg[g,t]
    )

    m.ext[:constraints][:upper_bound_pump_discharging] = @constraint(m, [g = G_pump, t = T],
    pg[g,t]+rg_lg1[g,t] <= pmax[g]*zg[g,t]
    )

    m.ext[:constraints][:lower_bound_pump_discharging] = @constraint(m, [g = G_pump, t = T],
    pmin[g]*zg[g,t] <=  pg[g,t]+rg_lg1[g,t]
    )

    #-P_pump is included since the charging of the pump is provided as a negative power in the input data.
    m.ext[:constraints][:upper_bound_pump_charging] = @constraint(m, [g = G_pump, t = T],
    p_charge_pump[g,t] <= (-P_pump[g] )* (1 -zg[g,t])
    )

    #Minimun charging power assumed as 10% of the maximum charging power (this is an assumption that can be changed based on the characteristics of the pump)
    m.ext[:constraints][:lower_bound_pump_charging] = @constraint(m, [g = G_pump, t = T],
    p_charge_pump[g,t] >= 0.1*(-P_pump[g] )* (1 -zg[g,t])
    )


    m.ext[:constraints][:initial_energy_value_pump] = @constraint(m, [g in G_pump],
        e_pump[g, Tlabels[1]] == E_reservoirs_ini[g]
    )

    m.ext[:constraints][:end_energy_value_pump] = @constraint(m, [g in G_pump],
        E_reservoirs_end[g] ==
            e_pump[g, Tlabels[NT]] +
            p_charge_pump[g, Tlabels[NT]]*G_npumping[g] -
            pg[g, Tlabels[NT]]/G_ngenerating[g]
    )
    m.ext[:constraints][:energy_balance_pump] = @constraint(m, [g in G_pump, k in 1:NT-1],
        e_pump[g, Tlabels[k+1]] ==
            e_pump[g, Tlabels[k]] +
            p_charge_pump[g, Tlabels[k]]*G_npumping[g] -
            pg[g, Tlabels[k]]/G_ngenerating[g]
    )


#Reservoir constraints
    m.ext[:constraints][:reservoir_operation_max] = @constraint(m, [g in G_reservoir, t in T],
        pg[g,t]+rg_lg1[g,t] <= pmax[g]*zg[g,t]
    )

     m.ext[:constraints][:reservoir_operation_min] = @constraint(m, [g in G_reservoir, t in T],
        pg[g,t]+rg_lg1[g,t] >= pmin[g]*zg[g,t]
    )
    m.ext[:constraints][:reserve_reservoir] = @constraint(m, [g in G_reservoir, t in T],
    rg_lg1[g,t] <= MaxFreqDev[g]* zg[g,t]
    )
    m.ext[:constraints][:initial_energy_value_reservoir] = @constraint(m, [g in G_reservoir, t in T],
        e_reservoir[g, Tlabels[1]] == E_reservoirs_ini[g]
    )
    
    
    m.ext[:constraints][:end_energy_value_reservoir] = @constraint(m, [g in G_reservoir, t in T],
        E_reservoirs_end[g] <=
            e_reservoir[g, Tlabels[NT]] -
            pg[g, Tlabels[NT]]/G_ngenerating[g]
    )

    m.ext[:constraints][:end_energy_value_reservoir]=@constraint(m, [g in G_reservoir, k in 1:NT-1],
        e_reservoir[g, Tlabels[k+1]] ==
            e_reservoir[g, Tlabels[k]] -
            pg[g, Tlabels[k]]/G_ngenerating[g]
    )






# Electrolyzer constraints

    #Hydrogen production constraint
        m.ext[:constraints][:hydrogen_production] = @constraint(m, [e in E, t in T],
        hfe[e,t] == pe[e,t]/Eefficiency[e]-0.05*Epmax[e]*zestb[e,t]/Eefficiency[e]
        )

    # Bounds on electrolyzer power considering standby
    m.ext[:constraints][:e_lower_bound] = @constraint(m, [e = E, t = T],
    pe[e,t] >= Epmin[e] * ze[e,t] + 0.05 * Epmax[e] * zestb[e,t]
    )    

    m.ext[:constraints][:e_upper_bound] = @constraint(m, [e = E, t = T],
    pe[e,t] <= Epmax[e] * ze[e,t] + 0.05 * Epmax[e] * zestb[e,t]
    )

    # Status constraint of electrolyzers (first time period)
    m.ext[:constraints][:e_status_ini] = @constraint(m, [e in E],
        zesu[e, Tlabels[1]] >= (ze[e, Tlabels[1]] - 1) + (zestb[e, Tlabels[1]] - 0)
    )

    # Startup constraint of electrolyzers (subsequent periods)
    m.ext[:constraints][:e_status_subsequent] = @constraint(m, [e in E, k in 2:NT],
    zesu[e, Tlabels[k]] >=
        (ze[e, Tlabels[k]]     - ze[e, Tlabels[k-1]]) +
        (zestb[e, Tlabels[k]]  - zestb[e, Tlabels[k-1]])
    )

    # Standby constraint of electrolyzers
    m.ext[:constraints][:e_standby] = @constraint(m, [e = E, t = T],
    zestb[e,t] + ze[e,t] <= 1
    )

        
    # Initial value of the hydrogen storage (relation between period 1 and 2)
        m.ext[:constraints][:initial_hydrogen_value] = @constraint(m, [e in E],
            hss[e, Tlabels[1]] == Estorageinitial[e]
        )
    # End value of the hydrogen storage
        m.ext[:constraints][:end_hydrogen_value] = @constraint(m, [e in E],
        Estorageend[e] ==
            hss[e, Tlabels[NT]] +
            hfe[e, Tlabels[NT]] -
            hfginyect[e, Tlabels[NT]] / Eeficiencycarga[e] +
            hfgconsum[e, Tlabels[NT]] * Eeficiencydischarge[e] -
            Eloadfactor[e] * Epmax[e] / Eefficiency[e]
        )

    # Charging–discharging of the hydrogen storage
        m.ext[:constraints][:charging_discharging_hydrogen] = @constraint(m, [e in E, k in 1:NT-1],
            hss[e, Tlabels[k+1]] ==
                hss[e, Tlabels[k]] +
                hfe[e, Tlabels[k]] -
                hfginyect[e, Tlabels[k]] / Eeficiencycarga[e] +
                hfgconsum[e, Tlabels[k]] * Eeficiencydischarge[e] -
                Eloadfactor[e] * Epmax[e] / Eefficiency[e]
        )
    #Compresor power constraint
        m.ext[:constraints][:compressor_power] = @constraint(m, [e in E, t in T],
        pe_compressor[e,t] == Ecompressorpower[e]*(hfe[e,t]+hfgconsum[e,t]+hfginyect[e,t])
        )

    
#     #Events constraints (loss of generators)
    m.ext[:constraints][:gen_constraint_1]= @constraint(m, [g=G,t=T],
    pg[g,t]<=plg1[t]
    )

    # m.ext[:constraints][:loss_renewable_1]= @constraint(m, [t=T],
    #   w["Nordic"][t]-rcu[t] <=plg1[t]
    # )
    m.ext[:constraints][:single_event_generator_1]= @constraint(m, [t=T],
    sum(δg[g,t] for g in G) ==1
    )
 

    bigMG=Dict()
    for g in G
        bigMG[g]=maximum(values(pmax))
    end

   
    m.ext[:constraints][:big_m1_gen_1]= @constraint(m, [g=G,t=T],
    (δg[g,t]-1)*bigMG[g]<= plg1[t]-pg[g,t]
    )
    m.ext[:constraints][:big_m2_gen_1]= @constraint(m, [g=G,t=T],
    plg1[t]-pg[g,t] <= (1-δg[g,t])*bigMG[g]
    )
    

    Inertia_nadir_frequency_1=Dict()

    for t in T 
        Inertia_nadir_frequency_1[t]=sum((zg[g,t]-δg[g,t])*ic[g]*pmax[g] for g in G)

    end
    

  #bounding the FFR and FCR contributions of all generator andconverter assets
  m.ext[:constraints][:fcr_bound_gen_lg1]= @constraint(m, [g in G, t in T],
     rg_lg1[g,t]<=(1-δg[g,t])*MaxFreqDev[g]
    )
  
        #Reserve storage bound constraints per areas and type of contigency
        m.ext[:constraints][:reserve_storage_lg1]=@constraint(m, [s=S, t=T],
            rs_lg1[s,t] <=  Spmax[s]+psc[s,t]-psd[s,t]
        )
        m.ext[:constraints][:reserve_electrolyzer_lg1]=@constraint(m, [e=E, t=T],
            re_lg1[e,t] <=  pe[e,t]-Epmin[e] * ze[e,t] 
        )


   # Constraint frequency nadir generators and converters area 1

    m.ext[:constraints][:nadir_frequency_g_1_constraint_1]= @constraint(m, [t in T],
    ypg1[t]==2*deltaf*(Inertia_nadir_frequency_1[t])/f1-sum(re_lg1[e,t]*Edeployment[e] for e in E)/2-sum(rs_lg1[s,t]*Sdeployment[s] for s in S)/2)

    m.ext[:constraints][:nadir_frequency_g_1_constraint_2]= @constraint(m, [t in T],
    zpg1[t]==sum(rg_lg1[g,t]/G_dt[g] for g in G)   
    )


    m.ext[:constraints][:nadir_frequency_g_1_constraint_3] = @constraint(m,[t in T],
    [ypg1[t]; zpg1[t]; plg1[t]-sum(re_lg1[e,t] for e in E)-sum(rs_lg1[s,t] for s in S)] in RotatedSecondOrderCone()
    )

        m.ext[:constraints][:time_nadir_occurrence_g1_1]= @constraint(m, [t in T],
    plg1[t]<= 0.0000001+sum(re_lg1[e,t] for e in E)+sum(rs_lg1[s,t] for s in S)+sum(rg_lg1[g,t] for g in G)
    )
    m.ext[:constraints][:time_nadir_occurrence_g1_2]= @constraint(m, [t in T],
    plg1[t]>=0.0000001+sum(re_lg1[e,t] for e in E)+sum(rs_lg1[s,t] for s in S)+sum(rg_lg1[g,t] for g in G)*Edeployment["1"]/G_dt["1"]
    )

    m.ext[:constraints][:time_nadir_power_balance]= @constraint(m, [t in T],
    plg1[t]<=sum(re_lg1[e,t] for e in E)+sum(rs_lg1[s,t] for s in S)+sum(rg_lg1[g,t] for g in G)
    )

    return m 
end
