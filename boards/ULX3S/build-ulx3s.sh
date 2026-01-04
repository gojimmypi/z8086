
cd ..

mkdir -p build


yosys -p "read_verilog -sv -DULX3S \
    boards/ULX3S/top_ulx3s.sv \
    boards/ULX3S/vram_ecp5.sv \
    boards/ULX3S/pll_black_box.sv \
    boards/ULX3S/ecp5_io_blackbox.sv \
    src/z8086/alu.sv \
    src/z8086/z8086.sv \
    src/soc_hdmi/z8086hdmi.sv \
    src/soc_hdmi/z8086soc.sv \
    src/soc_hdmi/uart_simple.sv \
    src/soc_hdmi/spram.sv \
    src/soc_hdmi/sprom.sv \
    src/soc_hdmi/hdmi/hdmi.sv \
    src/soc_hdmi/hdmi/tmds_channel.sv \
    src/soc_hdmi/hdmi/serializer.sv \
    src/soc_hdmi/hdmi/packet_assembler.sv \
    src/soc_hdmi/hdmi/packet_picker.sv \
    src/soc_hdmi/hdmi/audio_sample_packet.sv \
    src/soc_hdmi/hdmi/audio_info_frame.sv \
    src/soc_hdmi/hdmi/audio_clock_regeneration_packet.sv \
    src/soc_hdmi/hdmi/auxiliary_video_information_info_frame.sv \
    src/soc_hdmi/hdmi/source_product_description_info_frame.sv ; \
    hierarchy -top top -check ; \
    stat"


# ecppll -i 25 -o 25 -o 125 -n pll74 -f boards/ULX3S/pll74.sv


yosys -p "read_verilog -sv -DULX3S \
    boards/ULX3S/top_ulx3s.sv \
    boards/ULX3S/vram_ecp5.sv \
    boards/ULX3S/pll_black_box.sv \
    boards/ULX3S/pll27.sv \
    boards/ULX3S/pll74.sv \
    boards/ULX3S/ecp5_io_blackbox.sv \
    boards/ULX3S/obufds_blackbox.sv \
    src/z8086/alu.sv \
    src/z8086/z8086.sv \
    src/soc_hdmi/z8086hdmi.sv \
    src/soc_hdmi/z8086soc.sv \
    src/soc_hdmi/uart_simple.sv \
    src/soc_hdmi/spram.sv \
    src/soc_hdmi/sprom.sv \
    src/soc_hdmi/hdmi/hdmi.sv \
    src/soc_hdmi/hdmi/tmds_channel.sv \
    src/soc_hdmi/hdmi/serializer.sv \
    src/soc_hdmi/hdmi/packet_assembler.sv \
    src/soc_hdmi/hdmi/packet_picker.sv \
    src/soc_hdmi/hdmi/audio_sample_packet.sv \
    src/soc_hdmi/hdmi/audio_info_frame.sv \
    src/soc_hdmi/hdmi/audio_clock_regeneration_packet.sv \
    src/soc_hdmi/hdmi/auxiliary_video_information_info_frame.sv \
    src/soc_hdmi/hdmi/source_product_description_info_frame.sv ; \
    synth_ecp5 -top top_ulx3s -json build/top.json"


nextpnr-ecp5 --package CABGA381 --json build/top.json --lpf boards/ULX3S/ulx3s_v20.lpf --textcfg top.config


ecppack top.config top.bit
