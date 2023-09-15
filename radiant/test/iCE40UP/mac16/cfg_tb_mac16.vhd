library iCE40UP_model;

configuration cfg_wrapper_mac16_model of wrapper_mac16 is
  for struct
    for U_MAC16: mac16
      use entity iCE40UP_model.mac16;
    end for;
  end for;
end configuration cfg_wrapper_mac16_model;

configuration cfg_wrapper_mac16_vendor of wrapper_mac16 is
  for struct
    for U_MAC16: mac16
      use entity iCE40UP.mac16;
    end for;
  end for;
end configuration cfg_wrapper_mac16_vendor;

configuration cfg_tb_mac16 of tb_mac16 is
  for sim
    for DUT_1: wrapper_mac16
      use configuration work.cfg_wrapper_mac16_model;
    end for;
    for DUT_2: wrapper_mac16
      use configuration work.cfg_wrapper_mac16_vendor;
    end for;
  end for;
end configuration cfg_tb_mac16;
