function plotfunction_frequency_Nordic!(m::Model)
    
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
    G_solar = m.ext[:sets][:G_solar]
    G_wind = m.ext[:sets][:G_wind]
    
    T= m.ext[:sets][:t]

    S = m.ext[:sets][:S]

    E= m.ext[:sets][:E]


    # Extract parameters
  
    f1 = m.ext[:parameters][:f1]

    deltaf = m.ext[:parameters][:deltaf]
    ic = m.ext[:parameters][:ic]
         

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


baseKG=m.ext[:parameters][:baseKG]
baseMVA=m.ext[:parameters][:baseMVA]
pg=JuMP.value.(m.ext[:variables][:pg])*baseMVA
zg=JuMP.value.(m.ext[:variables][:zg])
δg=JuMP.value.(m.ext[:variables][:δg])
grouped = Dict(i => String[] for i in axes(δg, 1))

for i in axes(δg, 1), j in axes(δg, 2)
    if isapprox(δg[i, j], 1.0; atol=1e-6)
        push!(grouped[i], j)
    end
end

grouped = Dict(i => js for (i, js) in grouped if !isempty(js))

zg_vec_thermal = [zg[g,t] for g in TG, t in T]
zg_vec_hydro = [zg[g,t] for g in G_reservoir, t in T]
zg_vec_pump = [zg[g,t] for g in G_pump, t in T]
pgvec= [pg[g,t] for g in G, t in T]
pgreservoir_vec= [pg[g,t] for g in G_reservoir, t in T]
pgpump_vec=[pg[g,t] for g in G_pump, t in T]
PT_vec= [pg[g,t] for g in TG, t in T]
PS_vec= [pg[g,t] for g in G_solar, t in T]
PW_vec= [pg[g,t] for g in G_wind, t in T]
pev=JuMP.value.(m.ext[:variables][:pe])*baseMVA
pevec= [pev[e,t] for e in E, t in T]
hfe=JuMP.value.(m.ext[:variables][:hfe])*baseKG
hfevec= [hfe[e,t] for e in E, t in T]
hss=JuMP.value.(m.ext[:variables][:hss])*baseKG
hssvec= [hss[e,t] for e in E, t in T]
hfgconsum=JuMP.value.(m.ext[:variables][:hfgconsum])*baseKG
hfgconsumvec= [hfgconsum[e,t] for e in E, t in T]
hfginyect=JuMP.value.(m.ext[:variables][:hfginyect])*baseKG
hfginyectvec= [hfginyect[e,t] for e in E, t in T]
psc=JuMP.value.(m.ext[:variables][:psc])*baseMVA
pscvec= [psc[s,t] for s in S, t in T]
psd=JuMP.value.(m.ext[:variables][:psd])*baseMVA
psdvec= [psd[s,t] for s in S, t in T]
pe_compressor=JuMP.value.(m.ext[:variables][:pe_compressor])*baseMVA
pevec_compressor= [pe_compressor[e,t] for e in E, t in T]
es=JuMP.value.(m.ext[:variables][:es])*baseMVA
esvec= [es[s,t] for s in S, t in T]
pg=JuMP.value.(m.ext[:variables][:pg])*baseMVA
pgvec= [pg[g,t] for g in G, t in T]
pg1= [pg[g,t] for g in G, t in T]
e_pump=JuMP.value.(m.ext[:variables][:e_pump])*baseMVA
epump_vec=[e_pump[g,t] for g in G_pump, t in T]
p_charge_pump=JuMP.value.(m.ext[:variables][:p_charge_pump])*baseMVA
P_charge_pump_vec=[p_charge_pump[g,t] for g in G_pump, t in T]
# pg2= [pg[g,t] for g in G2, t in T]
plg1= JuMP.value.(m.ext[:variables][:plg1])*baseMVA
plg1vec= Array(plg1)
zgvec= [zg[g,t] for g in G, t in T]
δgvec= [δg[g,t] for g in G, t in T]



rg_lg1=JuMP.value.(m.ext[:variables][:rg_lg1])*baseMVA


re_lg1=JuMP.value.(m.ext[:variables][:re_lg1])*baseMVA


rs_lg1=JuMP.value.(m.ext[:variables][:rs_lg1])*baseMVA


rg_lg1vec= [rg_lg1[g,t] for g in G, t in T]


re_lg1vec= [re_lg1[e,t] for e in E, t in T]


rs_lg1vec= [rs_lg1[s,t] for s in S, t in T]


#wind1vec= [v for (k,v) in sort(collect(total_wind["Nordic"]), by=x->parse(Int, x[1]))]*baseMVA

auxD = Dict{eltype(T), Float64}()
for t in T
    auxD[t] = sum(d["$n"][t] for n in keys(d)) * baseMVA
end

demandwithoutEB1=[v for (k,v) in sort(collect(auxD), by=x->parse(Int, x[1]))]
rg_l_reserve_1vec = rg_lg1.data
re_l_reserve_1vec = re_lg1.data
rs_l_reserve_1vec = rs_lg1.data



Procured_inertia=Dict{eltype(T), Float64}()
Inertia_nadir=Dict{eltype(T), Float64}()
for t in T
Procured_inertia[t]=sum(ic["$n"]*zg["$n",t]*pmax["$n"]*baseMVA/1000 for n in keys(ic))
Inertia_nadir[t]=sum(ic["$n"]*(zg["$n",t]-δg["$n",t])*pmax["$n"]*baseMVA/1000 for n in keys(ic))
end

Procured_inertia_vec=[v for (k,v) in sort(collect(Procured_inertia), by=x->parse(Int, x[1]))]
Inertia_nadir_vec=[v for (k,v) in sort(collect(Inertia_nadir), by=x->parse(Int, x[1]))]

fig_procured_inertia = Figure()
ax_procured_inertia = fig_procured_inertia[1, 1] = Axis(fig_procured_inertia,
    title = "Procured Inertia Area 1",
    xlabel = "Time (hours)",
    ylabel = "Inertia (GWs)"
)
lines!(ax_procured_inertia, Procured_inertia_vec, label = "Procured Inertia")
fig_procured_inertia[1, 2] = Legend(fig_procured_inertia, ax_procured_inertia, "Inertia", framevisible = false)
fig_procured_inertia

hydrogen_demand=Dict()
E=keys(Eloadfactor)
for t in T
    for e in E
    hydrogen_demand[t,e]=Eloadfactor[e] * Epmax[e] / Eefficiency[e];
    end
end
hydrogen_demand_vec=vec([hydrogen_demand[t,e] for e in E, t in T])*baseKG

fig1 = Figure()
ax = fig1[1, 1] = Axis(fig1,
    title = "Storage, Hydrogen flow, and Hydrogen demand",
    xlabel = "Time (hours)",
    ylabel = "Hydrogen Flow (Kg/h) and Storage (Kg)"
)

lines!(ax, hfginyectvec[1, :], label = "Hydrogen injected")
lines!(ax, hssvec[1, :], label = "Hydrogen stored")
lines!(ax, hfevec[1, :], label = "Hydrogen Electrolyzer")
lines!(ax, hfgconsumvec[1, :], label = "Hydrogen consumed")
lines!(ax, hydrogen_demand_vec, label = "Hydrogen demand")
lines!(ax, hydrogen_demand_vec+hfginyectvec[1, :], label = "Hydrogen demand plus Hydrogen injected", linestyle=:dash)
fig1[1, 2] = Legend(fig1, ax, "Hydrogen Flows", framevisible = false)
fig1



fig3 = Figure()
ax3 = fig3[1, 1] = Axis(fig3,
    title = "Energy and power flows of the storage Area 1",
    xlabel = "Time (hours)",
    ylabel = "Power (MW) and Storage (Mwh)"
)
lines!(ax3, pscvec[1, :], label = "charging power")
lines!(ax3, psdvec[1, :], label = "discharging power")
lines!(ax3, esvec[1, :], label = "Energy stored")
fig3[1, 2] = Legend(fig3, ax3, "Storage Power and Energy", framevisible = false)  
fig3

fig_storage_pump = Figure()
ax_storage_pump = fig_storage_pump[1, 1] = Axis(fig_storage_pump,
    title = "Energy and power flows of the storage pump",
    xlabel = "Time (hours)",
    ylabel = "Power (MW) and Storage (Mwh)"
)
lines!(ax_storage_pump, P_charge_pump_vec[5, :], label = "charging power pump")
#lines!(ax_storage_pump, epump_vec[5, :], label = "Energy stored pump")
lines!(ax_storage_pump, pgpump_vec[5, :], label = "Generated power pump")
fig_storage_pump[1, 2] = Legend(fig_storage_pump, ax_storage_pump, "Storage Pump Power and Energy", framevisible = false)
fig_storage_pump



fig5 = Figure()
ax5 = fig5[1, 1] = Axis(fig5,
    title = "Generation by unit Area 1",
    xlabel = "Time (hours)",
    ylabel = "Generation (MW)"
)
lines!(ax5, pg1[1, :], label = "Generator 1")
lines!(ax5, pg1[2, :], label = "Generator 2")
lines!(ax5, pg1[3, :], label = "Generator 3")
fig5[1, 2] = Legend(fig5, ax5, "Generation Area 1", framevisible = false)
fig5


fig7 = Figure()
ax7 = fig7[1, 1] = Axis(fig7,
    title = "Loss of power area 1",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)

lines!(ax7, plg1vec, label = "Loss generator 1")
# lines!(ax7, plc1vec, label = "Loss converter 1")
# lines!(ax7, plreserve_1vec, label = "Loss reserve Area 1")
fig7[1, 2] = Legend(fig7, ax7, "Power loss Area 1", framevisible = false)
fig7



fig9 = Figure()
ax9 = fig9[1, 1] = Axis(fig9,
     title  = "Reserve allocation Area 1 plg",
     xlabel = "Time (hours)",
     ylabel = "Reserve Power (MW)"
)
rg9    = vec(sum(rg_lg1vec,    dims=1))
re9    = vec(sum(re_lg1vec,    dims=1))
# rhvdc9 = vec(sum(rhvdc_lg1vec, dims=1))
rs9    = vec(sum(rs_lg1vec,    dims=1))
lines!(ax9, rg9, label = "Reserve thermal generators Area 1")
lines!(ax9, re9, label = "Reserve electrolyzers Area 1")
# lines!(ax9, rhvdc9, label = "Reserve HVDC Area 1")
lines!(ax9, rs9, label = "Reserve storage Area 1")
fig9[1, 2] = Legend(fig9, ax9, "Reserve Area 1", framevisible = false)
fig9



fig15=Figure()
ax15=fig15[1, 1] = Axis(fig15,
    title = "Demand without Electrolyzers and BESS",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax15, demandwithoutEB1, label = "Total Demand Area 1")
# lines!(ax15, demandwithoutEB2, label = "Total Demand Area 2")
fig15[1, 2] = Legend(fig15, ax15, "Demand", framevisible = false)
fig15

fig16=Figure()
ax16=fig16[1, 1] = Axis(fig16,
    title = "Demand with Electrolyzers and BESS",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax16, demandwithoutEB1+pevec[1,:]+pevec_compressor[1,:]+pscvec[1,:]-psdvec[1,:], label = "Demand Area 1 ")
# lines!(ax16, demandwithoutEB2+pevec[2,:]+pevec_compressor[2,:]+pscvec[2,:]-psdvec[2,:], label = "Demand Area 2 ")
fig16[1, 2] = Legend(fig16, ax16, "Demand with EB and BESS", framevisible = false)
fig16

fig17=Figure()
ax17=fig17[1, 1] = Axis(fig17,
    title = "Wind generation ",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax17, vec(sum(PW_vec, dims=1)), label = "Wind Area 1 ")
# lines!(ax17,wind2vec, label = "Wind Area 2")
fig17[1, 2] = Legend(fig17, ax17, "Wind Generation", framevisible = false)
fig17

fig18=Figure()
ax18=fig18[1, 1] = Axis(fig18,
    title = "Net demand Area ",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax18, demandwithoutEB1+pevec[1,:]+pevec_compressor[1,:]+pscvec[1,:]+vec(sum(P_charge_pump_vec, dims=1))- vec(sum(PW_vec, dims=1)), label = "Net Demand Area 1 ")
#
fig18[1, 2] = Legend(fig18, ax18, "Net Demand", framevisible = false)
fig18




fig31 = Figure()
ax31 = fig31[1, 1] = Axis(fig31,
     title  = "Reserve allocation Area 1 pl reserve",
     xlabel = "Time (hours)",
     ylabel = "Reserve Power (MW)"
)
rg31    = vec(sum(rg_l_reserve_1vec,    dims=1))
re31    = vec(sum(re_l_reserve_1vec,    dims=1))
rs31    = vec(sum(rs_l_reserve_1vec,    dims=1))
lines!(ax31, rg31, label = "Reserve thermal generators Area 1")
lines!(ax31, re31, label = "Reserve electrolyzers Area 1")
lines!(ax31, rs31, label = "Reserve storage Area 1")
fig31[1, 2] = Legend(fig31, ax31, "Reserve Area 1", framevisible = false)
fig31

figpgvec= Figure()
axpgvec = figpgvec[1, 1] = Axis(figpgvec,
     title  = "Syncrhonous generation",
     xlabel = "Time (hours)",
     ylabel = "Generation (MW)"
)
lines!(axpgvec, vec(sum(pgvec, dims=1)), label = "Generation")
figpgvec[1, 2] = Legend(figpgvec, axpgvec, "Generation", framevisible = false)
figpgvec

figsolar=Figure()
axsolar = figsolar[1, 1] = Axis(figsolar,
     title  = "Solar generation",
     xlabel = "Time (hours)",
     ylabel = "Generation (MW)"
)
lines!(axsolar, vec(sum(PS_vec, dims=1)), label = "Solar Generation")
figsolar[1, 2] = Legend(figsolar, axsolar, "Solar Generation", framevisible = false)
figsolar

figwind=Figure()
axwind = figwind[1, 1] = Axis(figwind,
     title  = "Wind generation",
     xlabel = "Time (hours)",
     ylabel = "Generation (MW)"
)
lines!(axwind, vec(sum(PW_vec, dims=1)), label = "Wind Generation")
figwind[1, 2] = Legend(figwind, axwind, "Wind Generation", framevisible = false)
figwind

figdemand_and_generation = Figure()
axdemand_and_generation = figdemand_and_generation[1, 1] = Axis(figdemand_and_generation,
     title  = "Demand and Generation",
     xlabel = "Time (hours)",
     ylabel = "Power (MW)"
)

lines!(axdemand_and_generation,vec(sum(PT_vec, dims=1))+vec(sum(pgpump_vec, dims=1))+vec(sum(pgreservoir_vec, dims=1)) , label = "Synchronous Generation")
lines!(axdemand_and_generation, demandwithoutEB1+pevec[1,:]+pevec_compressor[1,:]+pscvec[1,:]+vec(sum(P_charge_pump_vec, dims=1)), label = "Total demand")
lines!(axdemand_and_generation,vec(sum(pgreservoir_vec, dims=1)), label = "Hydro reservoir generation")
lines!(axdemand_and_generation,vec(sum(pgpump_vec, dims=1)), label = "Hydro pump generation")
lines!(axdemand_and_generation,vec(sum(PT_vec, dims=1)), label = "Thermal generation")
lines!(axdemand_and_generation,vec(sum(PS_vec, dims=1)), label = "Solar generation")
lines!(axdemand_and_generation,vec(sum(PW_vec, dims=1)), label = "Wind generation")
lines!(axdemand_and_generation,psdvec[1,:]+vec(sum(PT_vec, dims=1))+vec(sum(pgpump_vec, dims=1))+vec(sum(pgreservoir_vec, dims=1))+vec(sum(PS_vec, dims=1))+vec(sum(PW_vec, dims=1)), label = "Total generation", linestyle = :dot)
figdemand_and_generation[1, 2] = Legend(figdemand_and_generation, axdemand_and_generation, "Demand and Generation", framevisible = false)
figdemand_and_generation


figmaximum_generation_per_technology = Figure()

axmaximum_generation_per_technology = figmaximum_generation_per_technology[1, 1] = Axis(
    figmaximum_generation_per_technology,
    title  = "Maximum generation per technology",
    xlabel = "Time (hours)",
    ylabel = "Generation (MW)"
)
lines!(axmaximum_generation_per_technology,
    vec(maximum(PT_vec, dims=1)),
    label = "Thermal generation",
    color = :red
)
lines!(axmaximum_generation_per_technology,
    vec(maximum(PS_vec, dims=1)),
    label = "Solar generation",
    color = :goldenrod
)
lines!(axmaximum_generation_per_technology,
    vec(maximum(PW_vec, dims=1)),
    label = "Wind generation",
    color = :green
)
lines!(axmaximum_generation_per_technology,
    vec(maximum(pgpump_vec, dims=1)),
    label = "Hydro pump generation",
    linestyle = :dashdot,
    color = :brown
)
lines!(axmaximum_generation_per_technology,
    vec(maximum(pgreservoir_vec, dims=1)),
    label = "Hydro reservoir generation",
    linestyle = :dashdotdot,
    color = :blue
)
figmaximum_generation_per_technology[1, 2] = Legend(
    figmaximum_generation_per_technology,
    axmaximum_generation_per_technology,
    "Maximum Generation per Technology",
    framevisible = false
)
figmaximum_generation_per_technology



#Folder to save the figures
folder = raw"C:\Users\jcastano\.julia\dev\Nordic_Frequency_stability_constraint_UC\Figures"

for (name, fig) in [
    ("hydrogen_storage1.png", fig1),
    ("storage_power_energy_1.png", fig3),
    ("4_generation_area1.png", fig5),
    ("power_loss_area1.png", fig7),
    ("reserve_area1_plg.png", fig9),
    ("Demand_without_Electrolyzers_and_BESS.png", fig15),
    ("Demand_with_Electrolyzers_and_BESS.png", fig16),
    ("Wind_generation_Area_1_and_2.png", fig17),
    ("Net_demand_Area_1_and_2.png", fig18),
    ("Reserve_allocation_Area_1_pl_reserve.png", fig31),
    ("storage_pump.png", fig_storage_pump),
    ("Procured_inertia.png", fig_procured_inertia),
    ("Demand_and_Generation.png", figdemand_and_generation),
]
    save(joinpath(folder, name), fig)
end

Inertia_nadir_vec=round.(Inertia_nadir_vec, digits=2)
plg1vec=round.(plg1vec, digits=2)
total_re=round.(vec(sum(re_lg1vec, dims=1)), digits=2)
total_rs=round.(vec(sum(rs_lg1vec, dims=1)), digits=2)
total_rg=round.(vec(sum(rg_lg1vec, dims=1)), digits=2)


open(joinpath(folder, "output.txt"), "w") do io
    for x in eachindex(Inertia_nadir_vec)
        println(io, "Hour", x, "-> H=", Inertia_nadir_vec[x], ",  Ploss=", plg1vec[x], ",  Re=", total_re[x], ",  Rb=", total_rs[x], ",  Rg=", total_rg[x])
    end
end


end