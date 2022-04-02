package ZEBGuidelineMid
  model ChillerPlantExample "Primary only chiller plant system with water-side economizer"
    extends Modelica.Icons.Example;
    replaceable package MediumA = Buildings.Media.Air "Medium model";
    replaceable package MediumW = Buildings.Media.Water "Medium model";
    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal = roo.QRoo_flow / (1005 * 15) "Nominal mass flow rate at fan";
    parameter Modelica.Units.SI.Power P_nominal = 80E3 "Nominal compressor power (at y=1)";
    parameter Modelica.Units.SI.TemperatureDifference dTEva_nominal = 10 "Temperature difference evaporator inlet-outlet";
    parameter Modelica.Units.SI.TemperatureDifference dTCon_nominal = 10 "Temperature difference condenser outlet-inlet";
    parameter Real COPc_nominal = 3 "Chiller COP";
    parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal = 2 * roo.QRoo_flow / (4200 * 20) "Nominal mass flow rate at chilled water";
    parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal = 2 * roo.QRoo_flow / (4200 * 6) "Nominal mass flow rate at condenser water";
    parameter Modelica.Units.SI.PressureDifference dp_nominal = 500 "Nominal pressure difference";
    Buildings.Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = MediumA, m_flow_nominal = mAir_flow_nominal, dp(start = 249), m_flow(start = mAir_flow_nominal), nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, energyDynamics = Modelica.Fluid.Types.Dynamics.SteadyState, T_start = 293.15, dp_nominal = 750) "Fan for air flow through the data center" annotation(
      Placement(transformation(extent = {{348, -235}, {328, -215}})));
    Buildings.Fluid.HeatExchangers.DryCoilCounterFlow cooCoi(redeclare package Medium1 = MediumW, redeclare package Medium2 = MediumA, m2_flow_nominal = mAir_flow_nominal, m1_flow_nominal = mCHW_flow_nominal, m1_flow(start = mCHW_flow_nominal), m2_flow(start = mAir_flow_nominal), dp2_nominal = 249 * 3, UA_nominal = mAir_flow_nominal * 1006 * 5, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, dp1_nominal(displayUnit = "Pa") = 1000 + 89580) "Cooling coil" annotation(
      Placement(transformation(extent = {{300, -180}, {280, -160}})));
    Modelica.Blocks.Sources.Constant mFanFlo(k = mAir_flow_nominal) "Mass flow rate of fan" annotation(
      Placement(transformation(extent = {{298, -210}, {318, -190}})));
    Buildings.Examples.ChillerPlant.BaseClasses.SimplifiedRoom roo(redeclare package Medium = MediumA, nPorts = 2, rooLen = 50, rooWid = 30, rooHei = 3, m_flow_nominal = mAir_flow_nominal, QRoo_flow = 500000) "Room model" annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, origin = {248, -238})));
    Buildings.Fluid.Movers.FlowControlled_dp pumCHW(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal, m_flow(start = mCHW_flow_nominal), dp(start = 325474), nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, dp_nominal = 130000) "Chilled water pump" annotation(
      Placement(visible = true, transformation(origin = {218, 42}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
    Buildings.Fluid.Storage.ExpansionVessel expVesCHW(redeclare package Medium = MediumW, V_start = 1) "Expansion vessel" annotation(
      Placement(transformation(extent = {{248, -147}, {268, -127}})));
    Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc cooTow(redeclare package Medium = MediumW, m_flow_nominal = mCW_flow_nominal, PFan_nominal = 6000, TAirInWB_nominal(displayUnit = "degC") = 283.15, TApp_nominal = 6, dp_nominal = 14930 + 14930 + 74650, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) "Cooling tower" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {269, 239})));
    Buildings.Fluid.Movers.FlowControlled_m_flow pumCW(redeclare package Medium = MediumW, m_flow_nominal = mCW_flow_nominal, dp(start = 214992), nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, dp_nominal = 130000) "Condenser water pump" annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {358, 200})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium = MediumW, m_flow_nominal = mCW_flow_nominal, dpValve_nominal = 20902, dpFixed_nominal = 89580, y_start = 1, use_inputFilter = false) "Control valve for condenser water loop of chiller" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {218, 180})));
    Buildings.Fluid.Storage.ExpansionVessel expVesChi(redeclare package Medium = MediumW, V_start = 1) annotation(
      Placement(transformation(extent = {{236, 143}, {256, 163}})));
    Buildings.Fluid.Chillers.ElectricEIR chi(redeclare package Medium1 = MediumW, redeclare package Medium2 = MediumW, m1_flow_nominal = mCW_flow_nominal, m2_flow_nominal = mCHW_flow_nominal, dp2_nominal = 0, dp1_nominal = 0, per = Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD(), energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial) annotation(
      Placement(transformation(extent = {{274, 83}, {254, 103}})));
    Buildings.Fluid.Actuators.Valves.TwoWayLinear val6(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal, dpValve_nominal = 20902, dpFixed_nominal = 14930 + 89580, y_start = 1, use_inputFilter = false, from_dp = true) "Control valve for chilled water leaving from chiller" annotation(
      Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 270, origin = {358, 40})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium = MediumA, m_flow_nominal = mAir_flow_nominal) "Supply air temperature to data center" annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, origin = {288, -225})));
    Buildings.Fluid.Sensors.TemperatureTwoPort TCWLeaTow(redeclare package Medium = MediumW, m_flow_nominal = mCW_flow_nominal) "Temperature of condenser water leaving the cooling tower" annotation(
      Placement(transformation(extent = {{10, -10}, {-10, 10}}, origin = {330, 119})));
    Modelica.Blocks.Sources.Constant cooTowFanCon(k = 1) "Control singal for cooling tower fan" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {230, 271})));
    Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valByp(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal, dpValve_nominal = 20902, dpFixed_nominal = 14930, y_start = 0, use_inputFilter = false, from_dp = true) "Bypass valve for chiller." annotation(
      Placement(visible = true, transformation(origin = {284, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Buildings.Fluid.Sensors.TemperatureTwoPort TCHWLeaCoi(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal) "Temperature of chilled water leaving the cooling coil" annotation(
      Placement(visible = true, transformation(origin = {218, -150}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaData(filNam = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")) annotation(
      Placement(transformation(extent = {{-360, -100}, {-340, -80}})));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation(
      Placement(transformation(extent = {{-332, -98}, {-312, -78}})));
    Modelica.Blocks.Sources.RealExpression PHVAC(y = fan.P + pumCHW.P + pumCW.P + cooTow.PFan + chi.P) "Power consumed by HVAC system" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-290, -250})));
    Modelica.Blocks.Sources.RealExpression PIT(y = roo.QSou.Q_flow) "Power consumed by IT" annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}}, origin = {-290, -280})));
    Modelica.Blocks.Continuous.Integrator EHVAC(initType = Modelica.Blocks.Types.Init.InitialState, y_start = 0) "Energy consumed by HVAC" annotation(
      Placement(transformation(extent = {{-240, -260}, {-220, -240}})));
    Modelica.Blocks.Continuous.Integrator EIT(initType = Modelica.Blocks.Types.Init.InitialState, y_start = 0) "Energy consumed by IT" annotation(
      Placement(transformation(extent = {{-240, -290}, {-220, -270}})));
  Modelica.Blocks.Sources.Constant pumCWCon(k = mCW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {322, 201}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant val5Con(k = 1) annotation(
      Placement(visible = true, transformation(origin = {180, 181}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant valBypCon(k = 0) annotation(
      Placement(visible = true, transformation(origin = {258, -33}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant val6Con(k = 1) annotation(
      Placement(visible = true, transformation(origin = {318, 43}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant chiTSet(k = 273.15 + 10) annotation(
      Placement(visible = true, transformation(origin = {250, 69}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant chiOn annotation(
      Placement(visible = true, transformation(origin = {182, 122}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant pumCHWCon(k = 20 * 6485) annotation(
      Placement(visible = true, transformation(origin = {174, 41}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.FixedResistances.Junction junCHWSup(redeclare package Medium = MediumW, dp_nominal = {0, 0, 0}, m_flow_nominal = mCHW_flow_nominal * {1, -1, 1})  annotation(
      Placement(visible = true, transformation(origin = {360, 10}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWEntChi(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {218, 70}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
  Buildings.Fluid.FixedResistances.Junction junCHWRet(redeclare package Medium = MediumW, dp_nominal = {0, 0, 0}, m_flow_nominal = mCHW_flow_nominal * {1, -1, 1}) annotation(
      Placement(visible = true, transformation(origin = {218, -16}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Buildings.Fluid.Movers.FlowControlled_dp pumCHW2(redeclare package Medium = MediumW, dp(start = 325474), dp_nominal = 130000, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow(start = mCHW_flow_nominal), m_flow_nominal = mCHW_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false) annotation(
      Placement(visible = true, transformation(origin = {-50, 40}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWEntChi2(redeclare package Medium = MediumW, m_flow_nominal = mCHW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {-50, 70}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
  Modelica.Blocks.Sources.Constant chi2TSet(k = 273.15 + 10) annotation(
      Placement(visible = true, transformation(origin = {-20, 67}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant val6_2Con(k = 1) annotation(
      Placement(visible = true, transformation(origin = {50, 41}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanConstant chi2On annotation(
      Placement(visible = true, transformation(origin = {-90, 120}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant cooTowFan2Con(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-68, 288}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Storage.ExpansionVessel expVesChi2(redeclare package Medium = MediumW, V_start = 1) annotation(
      Placement(visible = true, transformation(extent = {{-34, 143}, {-14, 163}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant val5_2con(k = 1) annotation(
      Placement(visible = true, transformation(origin = {-90, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant pumCW2Con(k = mCW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {50, 200}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Chillers.ElectricEIR chi2(redeclare package Medium1 = MediumW, redeclare package Medium2 = MediumW, dp1_nominal = 0, dp2_nominal = 0, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m1_flow_nominal = mCW_flow_nominal, m2_flow_nominal = mCHW_flow_nominal, per = Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD()) annotation(
      Placement(visible = true, transformation(extent = {{4, 83}, {-16, 103}}, rotation = 0)));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumCW2(redeclare package Medium = MediumW, dp(start = 214992), dp_nominal = 130000, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = mCW_flow_nominal, nominalValuesDefineDefaultPressureCurve = true, use_inputFilter = false) annotation(
      Placement(visible = true, transformation(origin = {90, 200}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc cooTow2(redeclare package Medium = MediumW, PFan_nominal = 6000, TAirInWB_nominal(displayUnit = "degC") = 283.15, TApp_nominal = 6, dp_nominal = 14930 + 14930 + 74650, energyDynamics = Modelica.Fluid.Types.Dynamics.FixedInitial, m_flow_nominal = mCW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {0, 237}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant pumCHW2Con(k = 20 * 6485) annotation(
      Placement(visible = true, transformation(origin = {-100, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val6_2(redeclare package Medium = MediumW, dpFixed_nominal = 14930 + 89580, dpValve_nominal = 20902, from_dp = true, m_flow_nominal = mCHW_flow_nominal, use_inputFilter = false, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {90, 40}, extent = {{-10, 10}, {10, -10}}, rotation = 270)));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val5_2(redeclare package Medium = MediumW, dpFixed_nominal = 89580, dpValve_nominal = 20902, m_flow_nominal = mCW_flow_nominal, use_inputFilter = false, y_start = 1) annotation(
      Placement(visible = true, transformation(origin = {-50, 180}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCWLeaTow2(redeclare package Medium = MediumW, m_flow_nominal = mCW_flow_nominal) annotation(
      Placement(visible = true, transformation(origin = {60, 117}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  equation
    connect(expVesCHW.port_a, cooCoi.port_b1) annotation(
      Line(points = {{258, -147}, {258, -164}, {280, -164}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(cooTow.port_b, pumCW.port_a) annotation(
      Line(points = {{279, 239}, {358, 239}, {358, 210}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(val5.port_a, chi.port_b1) annotation(
      Line(points = {{218, 170}, {218, 99}, {254, 99}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(expVesChi.port_a, chi.port_b1) annotation(
      Line(points = {{246, 143}, {246, 99}, {254, 99}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(cooTowFanCon.y, cooTow.y) annotation(
      Line(points = {{241, 271}, {250, 271}, {250, 247}, {257, 247}}, color = {0, 0, 127}, smooth = Smooth.None, pattern = LinePattern.Dash));
    connect(cooCoi.port_b2, fan.port_a) annotation(
      Line(points = {{300, -176}, {359, -176}, {359, -225}, {348, -225}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(mFanFlo.y, fan.m_flow_in) annotation(
      Line(points = {{319, -200}, {338, -200}, {338, -213}}, color = {0, 0, 127}, smooth = Smooth.None, pattern = LinePattern.Dash));
    connect(TAirSup.port_a, fan.port_b) annotation(
      Line(points = {{298, -225}, {328, -225}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(roo.airPorts[1], TAirSup.port_b) annotation(
      Line(points = {{250.475, -229.3}, {250.475, -225}, {278, -225}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(roo.airPorts[2], cooCoi.port_a2) annotation(
      Line(points = {{246.425, -229.3}, {246.425, -225}, {218, -225}, {218, -176}, {280, -176}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(TCWLeaTow.port_b, chi.port_a1) annotation(
      Line(points = {{320, 119}, {300, 119}, {300, 99}, {274, 99}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(weaData.weaBus, weaBus) annotation(
      Line(points = {{-340, -90}, {-331, -90}, {-331, -88}, {-322, -88}}, color = {255, 204, 51}, thickness = 0.5, smooth = Smooth.None),
      Text(textString = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
    connect(cooTow.TAir, weaBus.TWetBul) annotation(
      Line(points = {{257, 243}, {82, 243}, {82, 268}, {-322, 268}, {-322, -88}}, color = {0, 0, 127}, smooth = Smooth.None, pattern = LinePattern.Dash),
      Text(textString = "%second", index = 1, extent = {{6, 3}, {6, 3}}));
    connect(val5.port_b, cooTow.port_a) annotation(
      Line(points = {{218, 190}, {218, 239}, {259, 239}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(pumCW.port_b, TCWLeaTow.port_a) annotation(
      Line(points = {{358, 190}, {358, 119}, {340, 119}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(chi.port_b2, val6.port_a) annotation(
      Line(points = {{274, 87}, {358, 87}, {358, 50}}, color = {0, 127, 255}, smooth = Smooth.None, thickness = 0.5));
    connect(PHVAC.y, EHVAC.u) annotation(
      Line(points = {{-279, -250}, {-242, -250}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(PIT.y, EIT.u) annotation(
      Line(points = {{-279, -280}, {-242, -280}}, color = {0, 0, 127}, smooth = Smooth.None));
    connect(pumCW.m_flow_in, pumCWCon.y) annotation(
      Line(points = {{346, 200}, {333, 200}, {333, 201}}, color = {0, 0, 127}));
    connect(val5.y, val5Con.y) annotation(
      Line(points = {{206, 180}, {199, 180}, {199, 182}, {192, 182}}, color = {0, 0, 127}));
  connect(valBypCon.y, valByp.y) annotation(
      Line(points = {{269, -33}, {284, -33}, {284, -48}}, color = {0, 0, 127}));
    connect(val6.y, val6Con.y) annotation(
      Line(points = {{346, 40}, {330, 40}, {330, 44}}, color = {0, 0, 127}));
    connect(cooCoi.port_b1, TCHWLeaCoi.port_a) annotation(
      Line(points = {{280, -164}, {218, -164}, {218, -160}}, color = {0, 127, 255}));
    connect(chiTSet.y, chi.TSet) annotation(
      Line(points = {{261, 69}, {276, 69}, {276, 90}}, color = {0, 0, 127}));
    connect(chiOn.y, chi.on) annotation(
      Line(points = {{193, 122}, {276, 122}, {276, 96}}, color = {255, 0, 255}));
    connect(pumCHWCon.y, pumCHW.dp_in) annotation(
      Line(points = {{185, 41}, {192, 41}, {192, 42}, {206, 42}}, color = {0, 0, 127}));
    connect(chi.port_a2, TCHWEntChi.port_b) annotation(
      Line(points = {{254, 88}, {218, 88}, {218, 80}}, color = {0, 127, 255}));
    connect(pumCHW.port_b, TCHWEntChi.port_a) annotation(
      Line(points = {{218, 52}, {218, 60}}, color = {0, 127, 255}));
  connect(cooCoi.port_a1, junCHWSup.port_2) annotation(
      Line(points = {{300, -164}, {360, -164}, {360, 0}}, color = {0, 127, 255}));
  connect(TCHWLeaCoi.port_b, junCHWRet.port_2) annotation(
      Line(points = {{218, -140}, {218, -26}}, color = {0, 127, 255}));
  connect(pumCHW.port_a, junCHWRet.port_1) annotation(
      Line(points = {{218, 32}, {218, -6}}, color = {0, 127, 255}));
  connect(pumCW2.m_flow_in, pumCW2Con.y) annotation(
      Line(points = {{78, 200}, {65, 200}, {65, 201}}, color = {0, 0, 127}));
  connect(val5_2.port_b, cooTow2.port_a) annotation(
      Line(points = {{-50, 190}, {-50, 239}, {-9, 239}}, color = {0, 127, 255}, thickness = 0.5));
  connect(val5_2.port_a, chi2.port_b1) annotation(
      Line(points = {{-50, 170}, {-50, 99}, {-14, 99}}, color = {0, 127, 255}, thickness = 0.5));
  connect(TCWLeaTow2.port_b, chi2.port_a1) annotation(
      Line(points = {{50, 117}, {30, 117}, {30, 97}, {4, 97}}, color = {0, 127, 255}, thickness = 0.5));
  connect(chi2On.y, chi2.on) annotation(
      Line(points = {{-79, 120}, {4, 120}, {4, 94}}, color = {255, 0, 255}));
  connect(pumCHW2.port_b, TCHWEntChi2.port_a) annotation(
      Line(points = {{-50, 50}, {-50, 58}}, color = {0, 127, 255}));
  connect(pumCW2.port_b, TCWLeaTow2.port_a) annotation(
      Line(points = {{90, 190}, {90, 119}, {72, 119}}, color = {0, 127, 255}, thickness = 0.5));
  connect(chi2.port_a2, TCHWEntChi2.port_b) annotation(
      Line(points = {{-16, 87}, {-52, 87}, {-52, 79}}, color = {0, 127, 255}));
  connect(chi2.port_b2, val6_2.port_a) annotation(
      Line(points = {{4, 87}, {88, 87}, {88, 50}}, color = {0, 127, 255}, thickness = 0.5));
  connect(chi2TSet.y, chi2.TSet) annotation(
      Line(points = {{-9, 67}, {6, 67}, {6, 88}}, color = {0, 0, 127}));
  connect(cooTow2.port_b, pumCW2.port_a) annotation(
      Line(points = {{10, 237}, {89, 237}, {89, 208}}, color = {0, 127, 255}, thickness = 0.5));
  connect(val6_2.y, val6_2Con.y) annotation(
      Line(points = {{78, 40}, {62, 40}, {62, 44}}, color = {0, 0, 127}));
  connect(val5_2.y, val5_2con.y) annotation(
      Line(points = {{-62, 180}, {-69, 180}, {-69, 181}, {-77, 181}}, color = {0, 0, 127}));
  connect(cooTowFan2Con.y, cooTow2.y) annotation(
      Line(points = {{-57, 288}, {-38, 288}, {-38, 246}, {-13, 246}}, color = {0, 0, 127}, pattern = LinePattern.Dash));
  connect(expVesChi2.port_a, chi2.port_b1) annotation(
      Line(points = {{-24, 143}, {-24, 99}, {-16, 99}}, color = {0, 127, 255}, thickness = 0.5));
  connect(pumCHW2Con.y, pumCHW2.dp_in) annotation(
      Line(points = {{-89, 40}, {-82, 40}, {-82, 41}, {-68, 41}}, color = {0, 0, 127}));
  connect(junCHWSup.port_1, val6.port_b) annotation(
      Line(points = {{360, 20}, {360, 21}, {358, 21}, {358, 30}}, color = {0, 127, 255}));
  connect(valByp.port_b, junCHWSup.port_2) annotation(
      Line(points = {{294, -60}, {360, -60}, {360, 0}}, color = {0, 127, 255}));
  connect(valByp.port_a, TCHWLeaCoi.port_b) annotation(
      Line(points = {{274, -60}, {218, -60}, {218, -140}}, color = {0, 127, 255}));
  connect(junCHWSup.port_3, val6_2.port_b) annotation(
      Line(points = {{350, 10}, {90, 10}, {90, 30}}, color = {0, 127, 255}));
  connect(junCHWRet.port_3, pumCHW2.port_a) annotation(
      Line(points = {{208, -16}, {-50, -16}, {-50, 30}}, color = {0, 127, 255}));
  connect(cooTow2.TAir, weaBus.TWetBul) annotation(
      Line(points = {{-12, 242}, {-322, 242}, {-322, -88}}, color = {0, 0, 127}));
    annotation(
      Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-400, -300}, {400, 300}})),
      Documentation(info = "<HTML>
  <p>
  This model is the chilled water plant with discrete time control and
  trim and respond logic for a data center. The model is described at
  <a href=\"Buildings.Examples.ChillerPlant\">
  Buildings.Examples.ChillerPlant</a>.
  </p>
  </html>", revisions = "<html>
  <ul>
  <li>
  December 6, 2021, by Michael Wetter:<br/>
  Changed initialization from steady-state initial to fixed initial.<br/>
  This is for
  <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2798\">issue 2798</a>.
  </li>
  <li>
  November 18, 2021, by Michael Wetter:<br/>
  Set <code>dp_nominal</code> for pumps and fan to a realistic value.<br/>
  This is for
  <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2761\">#2761</a>.
  </li>
  <li>
  September 21, 2017, by Michael Wetter:<br/>
  Set <code>from_dp = true</code> in <code>val6</code> and in <code>valByp</code>
  which is needed for Dymola 2018FD01 beta 2 for
  <a href=\"modelica://Buildings.Examples.ChillerPlant.DataCenterDiscreteTimeControl\">
  Buildings.Examples.ChillerPlant.DataCenterDiscreteTimeControl</a>
  to converge.
  </li>
  <li>
  January 22, 2016, by Michael Wetter:<br/>
  Corrected type declaration of pressure difference.
  This is
  for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">IBPSA, #404</a>.
  </li>
  <li>
  January 13, 2015 by Michael Wetter:<br/>
  Moved model to <code>BaseClasses</code> because the continuous and discrete time
  implementation of the trim and respond logic do not extend from a common class,
  and hence the <code>constrainedby</code> operator is not applicable.
  Moving the model here allows to implement both controllers without using a
  <code>replaceable</code> class.
  </li>
  <li>
  January 12, 2015 by Michael Wetter:<br/>
  Made media instances replaceable, and used the same instance for both
  water loops.
  This was done to simplify the numerical benchmarks.
  </li>
  <li>
  December 22, 2014 by Michael Wetter:<br/>
  Removed <code>Modelica.Fluid.System</code>
  to address issue
  <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
  </li>
  <li>
  March 25, 2014, by Michael Wetter:<br/>
  Updated model with new expansion vessel.
  </li>
  <li>
  December 5, 2012, by Michael Wetter:<br/>
  Removed the filtered speed calculation for the valves to reduce computing time by 25%.
  </li>
  <li>
  October 16, 2012, by Wangda Zuo:<br/>
  Reimplemented the controls.
  </li>
  <li>
  July 20, 2011, by Wangda Zuo:<br/>
  Added comments and merge to library.
  </li>
  <li>
  January 18, 2011, by Wangda Zuo:<br/>
  First implementation.
  </li>
  </ul>
  </html>"),
  experiment(StartTime = 1.30464e+07, StopTime = 1.36512e+07, Tolerance = 1e-6, Interval = 60));
  end ChillerPlantExample;
  annotation(
    uses(Buildings(version = "9.0.0"), Modelica(version = "4.0.0")));
end ZEBGuidelineMid;
