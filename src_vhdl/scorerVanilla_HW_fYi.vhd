-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity scorerVanilla_HW_fYi_rom is 
    generic(
             DWIDTH     : integer := 8; 
             AWIDTH     : integer := 8; 
             MEM_SIZE    : integer := 130
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of scorerVanilla_HW_fYi_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "00000000", 1 => "00000001", 2 => "00000010", 3 => "00000011", 
    4 => "00000100", 5 => "00000101", 6 => "00000110", 7 => "00000111", 
    8 => "00001000", 9 => "00001001", 10 => "00001010", 11 => "00001011", 
    12 => "00001100", 13 => "00001101", 14 => "00001110", 15 => "00001111", 
    16 => "00010000", 17 => "00010001", 18 => "00010010", 19 => "00010011", 
    20 => "00010100", 21 => "00010101", 22 => "00010110", 23 => "00010111", 
    24 => "00011000", 25 => "00011001", 26 => "00011010", 27 => "00011011", 
    28 => "00011101", 29 => "00011110", 30 => "00011111", 31 => "00100000", 
    32 => "00100001", 33 => "00100010", 34 => "00100011", 35 => "00100100", 
    36 => "00100101", 37 => "00100110", 38 => "00100111", 39 => "00101000", 
    40 => "00101001", 41 => "00101010", 42 => "00101011", 43 => "00101100", 
    44 => "00101101", 45 => "00101110", 46 => "00101111", 47 => "00110000", 
    48 => "00110001", 49 => "00110010", 50 => "00110011", 51 => "00110100", 
    52 => "00110101", 53 => "00110110", 54 => "00110111", 55 => "00111000", 
    56 => "00111001", 57 => "00111010", 58 => "00111011", 59 => "00111100", 
    60 => "00111101", 61 => "00111110", 62 => "00111111", 63 => "01000000", 
    64 => "01000001", 65 => "01000010", 66 => "01000011", 67 => "01000100", 
    68 => "01000101", 69 => "01000110", 70 => "01000111", 71 => "01001000", 
    72 => "01001001", 73 => "01001010", 74 => "01001011", 75 => "01001100", 
    76 => "01001101", 77 => "01001110", 78 => "01001111", 79 => "01010000", 
    80 => "01010001", 81 => "01010010", 82 => "01010011", 83 => "01010100", 
    84 => "01010101", 85 => "01010110", 86 => "01010111", 87 => "01011000", 
    88 => "01011001", 89 => "01011010", 90 => "01011011", 91 => "01011100", 
    92 => "01011101", 93 => "01011110", 94 => "01100100", 95 => "01100101", 
    96 => "01100110", 97 => "01100111", 98 => "01101000", 99 => "01101001", 
    100 => "01101010", 101 => "01101011", 102 => "01101100", 103 => "01101101", 
    104 => "01101110", 105 => "01101111", 106 => "01110000", 107 => "01110001", 
    108 => "01110010", 109 => "01110011", 110 => "01110100", 111 => "01110101", 
    112 => "01110110", 113 => "01110111", 114 => "01111000", 115 => "01111001", 
    116 => "01111010", 117 => "01111011", 118 => "01111100", 119 => "01111101", 
    120 => "01111110", 121 => "01111111", 122 => "10000000", 123 => "10000001", 
    124 => "10000010", 125 => "10000011", 126 => "10000100", 127 => "10000101", 
    128 => "10000110", 129 => "10000111" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity scorerVanilla_HW_fYi is
    generic (
        DataWidth : INTEGER := 8;
        AddressRange : INTEGER := 130;
        AddressWidth : INTEGER := 8);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of scorerVanilla_HW_fYi is
    component scorerVanilla_HW_fYi_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    scorerVanilla_HW_fYi_rom_U :  component scorerVanilla_HW_fYi_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


