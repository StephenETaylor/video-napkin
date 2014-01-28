library verilog;
use verilog.vl_types.all;
entity stripes is
    port(
        CLOCK_27        : in     vl_logic;
        TD_CLK27        : in     vl_logic;
        TD_RESET        : out    vl_logic;
        VGA_R           : out    vl_logic_vector(9 downto 0);
        VGA_G           : out    vl_logic_vector(9 downto 0);
        VGA_B           : out    vl_logic_vector(9 downto 0);
        VGA_CLK         : out    vl_logic;
        VGA_BLANK       : out    vl_logic;
        VGA_HS          : out    vl_logic;
        VGA_VS          : out    vl_logic;
        VGA_SYNC        : out    vl_logic
    );
end stripes;
