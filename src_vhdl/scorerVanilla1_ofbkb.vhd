-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity scorerVanilla1_ofbkb_rom is 
    generic(
             DWIDTH     : integer := 16; 
             AWIDTH     : integer := 8; 
             MEM_SIZE    : integer := 131
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          addr1      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce1       : in std_logic; 
          q1         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of scorerVanilla1_ofbkb_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
signal addr1_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "0000000000000000", 1 => "0000000000011001", 2 => "0000000000101111", 
    3 => "0000000001100010", 4 => "0000000001101011", 5 => "0000000010000010", 
    6 => "0000000011001011", 7 => "0000000011100111", 8 => "0000000100110011", 
    9 => "0000000101000001", 10 => "0000000101111001", 11 => "0000010001100111", 
    12 => "0000010101010001", 13 => "0000100000000111", 14 => "0000101010100110", 
    15 => "0000110100011100", 16 => "0000111010100001", 17 => "0000111111111001", 
    18 => "0001000111000011", 19 => "0001001110000000", 20 => "0001010100001011", 
    21 => "0001010110111100", 22 => "0001010111000100", 23 => "0001010111100110", 
    24 => "0001010111101111", 25 => "0001011011101100", 26 => "0001011100101100", 
    27 => "0001011100101101", 28 => "0001011100110101", 29 => "0001011111100110", 
    30 => "0001100010011011", 31 => "0001100010011101", 32 => "0001100010110110", 
    33 => "0001100011000001", 34 => "0001100101000000", 35 => "0001101000010001", 
    36 => "0001101000011101", 37 => "0001101001010011", 38 => "0001101001110101", 
    39 => "0001101101010010", 40 => "0001110001000011", 41 => "0001110001011000", 
    42 => "0001110010111111", 43 => "0001110011011010", 44 => "0001110111101010", 
    45 => "0001111100000001", 46 => "0001111101010101", 47 => "0010000001110001", 
    48 => "0010000100111000", 49 => "0010001010010011", 50 => "0010001101101001", 
    51 => "0010001101111011", 52 => "0010001111100011", 53 => "0010010000010110", 
    54 => "0010010100001100", 55 => "0010011000001011", 56 => "0010011000101001", 
    57 => "0010011011111101", 58 => "0010011110001010", 59 => "0010100010001000", 
    60 => "0010100101110110", 61 => "0010100110010111", 62 => "0010101000111101", 
    63 => "0010101011000100", 64 => "0010101111001101", 65 => "0010110011101101", 
    66 => "0010110100011011", 67 => "0010110111100011", 68 => "0010111001011110", 
    69 => "0010111110000000", 70 => "0011000001100111", 71 => "0011000011001100", 
    72 => "0011000111101010", 73 => "0011001010110010", 74 => "0011001110111110", 
    75 => "0011010011101000", 76 => "0011010100001001", 77 => "0011010110110100", 
    78 => "0011011000100110", 79 => "0011011100111101", 80 => "0011100000010110", 
    81 => "0011100001000111", 82 => "0011100110111011", 83 => "0011101010101011", 
    84 => "0011101111000100", 85 => "0011110001111110", 86 => "0011110010111001", 
    87 => "0011110111100010", 88 => "0011111010011010", 89 => "0011111110000110", 
    90 => "0100000001111000", 91 => "0100000010111011", 92 => "0100000111110110", 
    93 => "0100001011001110", 94 => "0100001111001111", 95 => "0100010100110100", 
    96 => "0100010101100101", 97 => "0100011001010110", 98 => "0100011011110100", 
    99 => "0100100001100010", 100 => "0100100111001000", 101 => "0100101000011001", 
    102 => "0100101111111010", 103 => "0100110100111101", 104 => "0100111101011111", 
    105 => "0101000001101111", 106 => "0101000110100110", 107 => "0101001100000111", 
    108 => "0101001111100110", 109 => "0101010011100001", 110 => "0101010111100011", 
    111 => "0101011101000110", 112 => "0101100010000100", 113 => "0101100110110110", 
    114 => "0101101010101100", 115 => "0101101110101111", 116 => "0101110100101010", 
    117 => "0101111010011101", 118 => "0101111110111111", 119 => "0110000011010010", 
    120 => "0110001111010000", 121 => "0110100001111100", 122 => "0110101111010000", 
    123 => "0110111100010000", 124 => "0111010100010111", 125 => "0111110010111000", 
    126 => "1000000010110111", 127 => "1000010100010010", 128 => "1000011001011101", 
    129 => "1000100000000101", 130 => "1000100110010001" );


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

memory_access_guard_1: process (addr1) 
begin
      addr1_tmp <= addr1;
--synthesis translate_off
      if (CONV_INTEGER(addr1) > mem_size-1) then
           addr1_tmp <= (others => '0');
      else 
           addr1_tmp <= addr1;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
        if (ce1 = '1') then 
            q1 <= mem(CONV_INTEGER(addr1_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity scorerVanilla1_ofbkb is
    generic (
        DataWidth : INTEGER := 16;
        AddressRange : INTEGER := 131;
        AddressWidth : INTEGER := 8);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0);
        address1 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce1 : IN STD_LOGIC;
        q1 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of scorerVanilla1_ofbkb is
    component scorerVanilla1_ofbkb_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR;
            addr1 : IN STD_LOGIC_VECTOR;
            ce1 : IN STD_LOGIC;
            q1 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    scorerVanilla1_ofbkb_rom_U :  component scorerVanilla1_ofbkb_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0,
        addr1 => address1,
        ce1 => ce1,
        q1 => q1);

end architecture;


