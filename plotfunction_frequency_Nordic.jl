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
    wind= m.ext[:parameters][:wind]
    w= m.ext[:parameters][:w]
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
pgvec= [pg[g,t] for g in G, t in T]
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
pgpump_vec=[pg[g,t] for g in G_pump, t in T]
e_pump=JuMP.value.(m.ext[:variables][:e_pump])*baseMVA
epump_vec=[e_pump[g,t] for g in G_pump, t in T]
p_charge_pump=JuMP.value.(m.ext[:variables][:p_charge_pump])*baseMVA
P_charge_pump_vec=[p_charge_pump[g,t] for g in G_pump, t in T]
# pg2= [pg[g,t] for g in G2, t in T]
plg1= JuMP.value.(m.ext[:variables][:plg1])*baseMVA
plg1vec= Array(plg1)

rg_lg1=JuMP.value.(m.ext[:variables][:rg_lg1])*baseMVA


re_lg1=JuMP.value.(m.ext[:variables][:re_lg1])*baseMVA


rs_lg1=JuMP.value.(m.ext[:variables][:rs_lg1])*baseMVA


rg_lg1vec= [rg_lg1[g,t] for g in G, t in T]


re_lg1vec= [re_lg1[e,t] for e in E, t in T]


rs_lg1vec= [rs_lg1[s,t] for s in S, t in T]


wind1vec= [v for (k,v) in sort(collect(w["Nordic"]), by=x->parse(Int, x[1]))]*baseMVA

auxD = Dict{eltype(T), Float64}()
for t in T
    auxD[t] = sum(d["$n"][t] for n in keys(d)) * baseMVA
end

demandwithoutEB1=[v for (k,v) in sort(collect(auxD), by=x->parse(Int, x[1]))]
rg_l_reserve_1vec = rg_lg1.data
re_l_reserve_1vec = re_lg1.data
rs_l_reserve_1vec = rs_lg1.data

rcu=JuMP.value.(m.ext[:variables][:rcu])*baseMVA
rcu_vec= [rcu[t] for t in T]




fig1 = Figure()
ax = fig1[1, 1] = Axis(fig1,
    title = "Storage and Hydrogen flows Area 1",
    xlabel = "Time (hours)",
    ylabel = "Hydrogen Flow (Kg/h) and Storage (Kg)"
)

lines!(ax, hfginyectvec[1, :], label = "Hydrogen injected")
lines!(ax, hssvec[1, :], label = "Hydrogen stored")
lines!(ax, hfevec[1, :], label = "Hydrogen Electrolyzer")
lines!(ax, hfgconsumvec[1, :], label = "Hydrogen consumed")

# Legend in separate panel
fig1[1, 2] = Legend(fig1, ax, "Hydrogen Flows", framevisible = false)

fig1



# fig2 = Figure()
# ax2 = fig2[1, 1] = Axis(fig2,
#     title = "Storage and Hydrogen flows Area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Hydrogen Flow (Kg/h) and Storage (Kg)"
# )

# lines!(ax2, hfginyectvec[2, :], label = "Hydrogen injected")
# lines!(ax2, hssvec[2, :], label = "Hydrogen stored")
# lines!(ax2, hfevec[2, :], label = "Hydrogen Electrolyzer")
# lines!(ax2, hfgconsumvec[2, :], label = "Hydrogen consumed")

# fig2[1, 2] = Legend(fig2, ax2, "Hydrogen Flows", framevisible = false)  
# fig2

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
lines!(ax_storage_pump, epump_vec[5, :], label = "Energy stored pump")
lines!(ax_storage_pump, pgpump_vec[5, :], label = "Generated power pump")
fig_storage_pump[1, 2] = Legend(fig_storage_pump, ax_storage_pump, "Storage Pump Power and Energy", framevisible = false)
fig_storage_pump


# fig4 = Figure()
# ax4 = fig4[1, 1] = Axis(fig4,
#     title = "Energy and power flows of the storage Area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW) and Storage (Mwh)"
# )
# lines!(ax4, pscvec[2, :], label = "charging power")
# lines!(ax4, psdvec[2, :], label = "discharging power")
# lines!(ax4, esvec[2, :], label = "Energy stored")   
# fig4[1, 2] = Legend(fig4, ax4, "Storage Power and Energy", framevisible = false)
# fig4

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

# fig6 = Figure()
# ax6 = fig6[1, 1] = Axis(fig6,
#     title = "Generation by unit Area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Generation (MW)"
# )   
# lines!(ax6, pg2[1, :], label = "Generator 4")
# lines!(ax6, pg2[2, :], label = "Generator 5")
# lines!(ax6, pg2[3, :], label = "Generator 6")
# fig6[1, 2] = Legend(fig6, ax6, "Generation Area 2", framevisible = false)
# fig6

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

# fig8 = Figure()
# ax8 = fig8[1, 1] = Axis(fig8,
#     title = "Loss of power area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax8, plg2vec, label = "Loss generator 2")    
# lines!(ax8, plc2vec, label = "Loss converter 2")
# lines!(ax8, plreserve_2vec, label = "Loss reserve Area 2")
# fig8[1, 2] = Legend(fig8, ax8, "Power loss Area 2", framevisible = false)
# fig8

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


# fig10 = Figure()
# ax10 = fig10[1, 1] = Axis(fig10,
#      title  = "Reserve allocation Area 1 plc",
#      xlabel = "Time (hours)",
#      ylabel = "Reserve Power (MW)"
# )
# rg10    = vec(sum(rg_lc1vec,    dims=1))
# re10    = vec(sum(re_lc1vec,    dims=1))
# rhvdc10 = vec(sum(rhvdc_lc1vec, dims=1))
# rs10    = vec(sum(rs_lc1vec,    dims=1))
# lines!(ax10, rg10, label = "Reserve thermal generators Area 1")
# lines!(ax10, re10, label = "Reserve electrolyzers Area 1")
# lines!(ax10, rhvdc10, label = "Reserve HVDC Area 1")
# lines!(ax10, rs10, label = "Reserve storage Area 1")
# fig10[1, 2] = Legend(fig10, ax10, "Reserve Area 1", framevisible = false)
# fig10

# fig11 = Figure()
# ax11 = fig11[1, 1] = Axis(fig11,
#      title  = "Reserve allocation Area 2 plg",
#      xlabel = "Time (hours)",
#      ylabel = "Reserve Power (MW)"
# )
# rg11    = vec(sum(rg_lg2vec,    dims=1))
# re11    = vec(sum(re_lg2vec,    dims=1))
# rhvdc11 = vec(sum(rhvdc_lg2vec, dims=1))
# rs11    = vec(sum(rs_lg2vec,    dims=1))
# lines!(ax11, rg11, label = "Reserve thermal generators Area 2")
# lines!(ax11, re11, label = "Reserve electrolyzers Area 2")
# lines!(ax11, rhvdc11, label = "Reserve HVDC Area 2")
# lines!(ax11, rs11, label = "Reserve storage Area 2")
# fig11[1, 2] = Legend(fig11, ax11, "Reserve Area 2", framevisible = false)
# fig11

# fig12 = Figure()
# ax12 = fig12[1, 1] = Axis(fig12,
#      title  = "Reserve allocation Area 2 plc",
#      xlabel = "Time (hours)",
#      ylabel = "Reserve Power (MW)"
# )
# rg12    = vec(sum(rg_lc2vec,    dims=1))
# re12    = vec(sum(re_lc2vec,    dims=1))
# rhvdc12 = vec(sum(rhvdc_lc2vec, dims=1))
# rs12    = vec(sum(rs_lc2vec,    dims=1))
# lines!(ax12, rg12, label = "Reserve thermal generators Area 2")
# lines!(ax12, re12, label = "Reserve electrolyzers Area 2")
# lines!(ax12, rhvdc12, label = "Reserve HVDC Area 2")
# lines!(ax12, rs12, label = "Reserve storage Area 2")
# fig12[1, 2] = Legend(fig12, ax12, "Reserve Area 2", framevisible = false)
# fig12

# fig9 = Figure()
# ax9 = Axis(fig9[1, 1];
#     title  = "Reserve allocation Area 1",
#     xlabel = "Time (hours)",
#     ylabel = "Reserve Power (MW)"
# )
# ax9.xticklabelsize = 8
# ax9.xticklabelrotation = π/4
# rg9    = vec(sum(rgvec1,    dims=1))
# re9    = vec(sum(revec1,    dims=1))
# rhvdc9 = vec(sum(rhvdcvec1, dims=1))
# rs9    = vec(sum(rsvec1,    dims=1))
# T = length(rg9)
# M = hcat(re9, rg9, rhvdc9, rs9)
# positions = repeat(1:T, inner=4)
# heights   = vec(permutedims(M))
# groups    = repeat(1:4, T)
# barplot!(
#     ax9,
#     positions,
#     heights;
#     dodge = groups,
#     color = groups
# )
# ax9.xticks = (1:T, string.(0:T-1))
# labels = [
#     "Reserve thermal generators Area 1",
#     "Reserve electrolyzers Area 1",
#     "Reserve HVDC Area 1",
#     "Reserve storage Area 1"
# ]
# colors = Makie.wong_colors()[1:4]
# elements = [PolyElement(polycolor = colors[i]) for i in 1:4]
# Legend(
#     fig9[1, 2],
#     elements,
#     labels,
#     "Reserve Area 1";
#     framevisible = false
# )
# fig9

# fig10 = Figure()
# ax10 = Axis(fig10[1, 1];
#     title  = "Reserve allocation Area 2",
#     xlabel = "Time (hours)",
#     ylabel = "Reserve Power (MW)"
# )
# ax10.xticklabelsize = 8
# ax10.xticklabelrotation = π/4
# rg10    = vec(sum(rgvec2,    dims=1))
# re10    = vec(sum(revec2,    dims=1))
# rhvdc10 = vec(sum(rhvdcvec2, dims=1))
# rs10    = vec(sum(rsvec2,    dims=1))
# T = length(rg10)
# M = hcat(re10, rg10, rhvdc10, rs10)
# positions = repeat(1:T, inner=4)
# heights   = vec(permutedims(M))
# groups    = repeat(1:4, T)
# barplot!(
#     ax10,
#     positions,
#     heights;
#     dodge = groups,
#     color = groups
# )  
# ax10.xticks = (1:T, string.(0:T-1))
# labels = [
#     "Reserve thermal generators Area 2",
#     "Reserve electrolyzers Area 2",
#     "Reserve HVDC Area 2",
#     "Reserve storage Area 2"
# ] 
# colors = Makie.wong_colors()[1:4]
# elements = [PolyElement(polycolor = colors[i]) for i in 1:4]
# Legend(
#     fig10[1, 2],
#     elements,
#     labels,
#     "Reserve Area 2";
#     framevisible = false
# )       
# fig10  

# fig13 = Figure()
# ax13 = fig13[1, 1] = Axis(fig13,
#     title = "HVDC power flows",
#     xlabel = "Time (hours)",
#     ylabel = "Generation (MW)"
# )   
# lines!(ax13, flows_hvdc24, label = "Flow HVDC 2-4")
# lines!(ax13, flows_hvdc31, label = "Flow HVDC 3-1")
# fig13[1, 2] = Legend(fig13, ax13, "HVDC flows", framevisible = false)
# fig13

# fig14=Figure()
# ax14=fig14[1, 1] = Axis(fig14,
#     title = "Sum Of Power Flows HVDC Links",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax14,flows_hvdc24+flows_hvdc31, label = "Sum Of Flows 24 + 31")
# fig14[1, 2] = Legend(fig14, ax14, "Sum Of HVDC flows", framevisible = false)
# fig14

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
    title = "Wind generation Area 1 and 2",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax17, wind1vec, label = "Wind Area 1 ")
# lines!(ax17,wind2vec, label = "Wind Area 2")
fig17[1, 2] = Legend(fig17, ax17, "Wind Generation", framevisible = false)
fig17

fig18=Figure()
ax18=fig18[1, 1] = Axis(fig18,
    title = "Net demand Area ",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax18, demandwithoutEB1+pevec[1,:]+pevec_compressor[1,:]+pscvec[1,:]+rcu_vec+vec(sum(P_charge_pump_vec, dims=1))- wind1vec, label = "Net Demand Area 1 ")
# lines!(ax18, demandwithoutEB2+pevec[2,:]+pevec_compressor[2,:]+pscvec[2,:]-psdvec[2,:]- wind2vec-flows_hvdc24-flows_hvdc31, label = "Net Demand Area 2 ")
fig18[1, 2] = Legend(fig18, ax18, "Net Demand", framevisible = false)
fig18



sum(P_charge_pump_vec,dims=1)'

fig19=Figure()
ax19=fig19[1, 1] = Axis(fig19,
    title = "Net demand Area 1 and 2 without HVDC flows",
    xlabel = "Time (hours)",
    ylabel = "Power (MW)"
)
lines!(ax19, demandwithoutEB1+pevec[1,:]+pevec_compressor[1,:]+pscvec[1,:]-psdvec[1,:]- wind1vec, label = "Net Demand Area 1 ")
# lines!(ax19, demandwithoutEB2+pevec[2,:]+pevec_compressor[2,:]+pscvec[2,:]-psdvec[2,:]- wind2vec, label = "Net Demand Area 2 ")
fig19[1, 2] = Legend(fig19, ax19, "Net Demand", framevisible = false)
fig19

# fig20=Figure()
# ax20=fig20[1, 1] = Axis(fig20,
#     title = "Area 1 flows",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
#     lines!(ax20, pb_13, label = "Flow Bus 1 to 3")
#     lines!(ax20, pb_23, label = "Flow Bus 2 to 3")
#     lines!(ax20, pb_12, label = "Flow Bus 1 to 2")
# fig20[1, 2] = Legend(fig20, ax20, "Area 1 Flows", framevisible = false)
# fig20

# fig21=Figure()
# ax21=fig21[1, 1] = Axis(fig21,
#     title = "Area 2 flows",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
#     lines!(ax21, pb_56, label = "Flow Bus 5 to 6")
#     lines!(ax21, pb_45, label = "Flow Bus 4 to 5")
#     lines!(ax21, pb_46, label = "Flow Bus 4 to 6")
# fig21[1, 2] = Legend(fig21, ax21, "Area 2 Flows", framevisible = false)
# fig21


# fig22=Figure()
# ax22=fig22[1, 1] = Axis(fig22,
#     title = "Flow+Reserve",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
#     lines!(ax22, flows_hvdc31 + rhvdc_lg2vec[1,:], label = "Flow31 + Reserve Converter 1")
#     lines!(ax22, -flows_hvdc31 + rhvdc_lg1vec[2,:], label = "Flow13 + Reserve Converter 2")
#     lines!(ax22, flows_hvdc24 + rhvdc_lg2vec[2,:], label = "Flow24 + Reserve Converter 4")
#     lines!(ax22, -flows_hvdc24 + rhvdc_lg1vec[1,:], label = "Flow42 + Reserve Converter 2")
# fig22[1, 2] = Legend(fig22, ax22, "Flow + Reserve", framevisible = false)
# fig22

# fig23=Figure()
# ax23=fig23[1, 1] = Axis(fig23,
#     title = "Reserve per converter Area 1 plg",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax23, rhvdc_lg1vec[1,:], label = "Reserve Converter 2")
# lines!(ax23, rhvdc_lg1vec[2,:], label = "Reserve Converter 3")
# fig23[1, 2] = Legend(fig23, ax23, "Reserve per converter", framevisible = false)
# fig23

# fig24=Figure()
# ax24=fig24[1, 1] = Axis(fig24,
#     title = "Reserve per converter Area 1 plc",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax24, rhvdc_lc1vec[1,:], label = "Reserve Converter 2")
# lines!(ax24, rhvdc_lc1vec[2,:], label = "Reserve Converter 3")

# fig24[1, 2] = Legend(fig24, ax24, "Reserve per converter", framevisible = false)
# fig24

# fig25=Figure()
# ax25=fig25[1, 1] = Axis(fig25,
#     title = "Reserve per converter Area 2 plg",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax25, rhvdc_lg2vec[1,:], label = "Reserve Converter 1")
# lines!(ax25, rhvdc_lg2vec[2,:], label = "Reserve Converter 4")
# fig25[1, 2] = Legend(fig25, ax25, "Reserve per converter", framevisible = false)
# fig25

# fig26=Figure()
# ax26=fig26[1, 1] = Axis(fig26,
#     title = "Reserve per converter Area 2 plc",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax26, rhvdc_lc2vec[1,:], label = "Reserve Converter 1")
# lines!(ax26, rhvdc_lc2vec[2,:], label = "Reserve Converter 4")
# fig26[1, 2] = Legend(fig26, ax26, "Reserve per converter", framevisible = false)
# fig26

# fig27=Figure()
# ax27=fig27[1, 1] = Axis(fig27,
#     title = "Reserve per converter Area 1 plg and plc",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax27, rhvdc_lg1vec[1,:], label = "Reserve Converter 2 lg1")
# lines!(ax27, rhvdc_lg1vec[2,:], label = "Reserve Converter 3 lg1")
# lines!(ax27, rhvdc_lc1vec[1,:], label = "Reserve Converter 2 lc1")
# lines!(ax27, rhvdc_lc1vec[2,:], label = "Reserve Converter 3 lc1")
# fig27[1, 2] = Legend(fig27, ax27, "Reserve per converter", framevisible = false)
# fig27

# fig28=Figure()
# ax28=fig28[1, 1] = Axis(fig28,
#     title = "Reserve per converter Area 2 plg and plc",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )
# lines!(ax28, rhvdc_lg2vec[1,:], label = "Reserve Converter 1 lg2")
# lines!(ax28, rhvdc_lg2vec[2,:], label = "Reserve Converter 4 lg2")
# lines!(ax28, rhvdc_lc2vec[1,:], label = "Reserve Converter 1 lc2")
# lines!(ax28, rhvdc_lc2vec[2,:], label = "Reserve Converter 4 lc2")
# fig28[1, 2] = Legend(fig28, ax28, "Reserve per converter", framevisible = false)
# fig28

# fig29 = Figure()

# ax29 = fig29[1, 1] = Axis(fig29,
#     title = "Power per converter",
#     xlabel = "Time (hours)",
#     ylabel = "Power (MW)"
# )

# t = 1:size(conv_p_ac_vec, 2)

# barplot!(ax29, t .- 0.3, conv_p_ac_vec[1, :], width = 0.15, label = "Converter 1 AC power")
# barplot!(ax29, t .- 0.1, conv_p_ac_vec[2, :], width = 0.15, label = "Converter 2 AC power")
# barplot!(ax29, t .+ 0.1, conv_p_ac_vec[3, :], width = 0.15, label = "Converter 3 AC power")
# barplot!(ax29, t .+ 0.3, conv_p_ac_vec[4, :], width = 0.15, label = "Converter 4 AC power")

# fig29[1, 2] = Legend(fig29, ax29, "Power per converter", framevisible = false)

# fig29





# row_labels = collect(axes(δhvdc, 1))
# col_labels = collect(axes(δhvdc, 2))
# data = Array(δhvdc)

# x = 1:length(col_labels)

# fig30 = Figure(size = (1000, 450))

# ax = Axis(
#     fig30[1,1],
#     title = "Failure binary variable",
#     xlabel = "Time period",
#     ylabel = "δhvdc",
#     xticks = (x, col_labels),
#     yticks = 0:1
# )

# # width of each bar group
# n = size(data,1)
# bar_width = 0.8 / n

# for i in 1:n
#     xpos = x .- 0.4 .+ (i - 0.5) * bar_width
#     barplot!(ax, xpos, data[i,:],
#         width = bar_width,
#         label = "HVDC $(row_labels[i])"
#     )
# end

# axislegend(ax, position = :rb)

# fig30


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

# fig32 = Figure()
# ax32 = fig32[1, 1] = Axis(fig32,
#      title  = "Reserve allocation Area 2 pl reserve",
#      xlabel = "Time (hours)",
#      ylabel = "Reserve Power (MW)"
# )
# rg32    = vec(sum(rg_l_reserve_2vec,    dims=1))
# re32    = vec(sum(re_l_reserve_2vec,    dims=1))
# rs32    = vec(sum(rs_l_reserve_2vec,    dims=1))
# lines!(ax32, rg32, label = "Reserve thermal generators Area 2")
# lines!(ax32, re32, label = "Reserve electrolyzers Area 2")
# lines!(ax32, rs32, label = "Reserve storage Area 2")
# fig32[1, 2] = Legend(fig32, ax32, "Reserve Area 2", framevisible = false)
# fig32




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
    ("Net_demand_Area_1_and_2_without_HVDC_flows.png", fig19),
    ("Reserve_allocation_Area_1_pl_reserve.png", fig31),
    ("storage_pump.png", fig_storage_pump)
]
    save(name, fig)
end
end


