library ieee;
use ieee.std_logic_1164.all;

entity exp7 is
	port( Data: in std_logic_vector(7 downto 0);
			Control: in std_logic_vector(7 downto 0);
			Clock: in std_logic;
			HEX_Bus: out std_logic_vector(13 downto 0);
			HEX_Rs: out std_logic_vector(13 downto 0);
			HEX_Rt: out std_logic_vector(13 downto 0);
			Done: out std_logic);
end exp7;

architecture exp7_arch of exp7 is


	component Simple_CPU
		port( Data: in std_logic_vector(7 downto 0);
				Control: in std_logic_vector(7 downto 0);
				Clock: in std_logic;
				D_Bus: out std_logic_vector(7 downto 0);
				D_Rs: out std_logic_vector(7 downto 0);
				D_Rt: out std_logic_vector(7 downto 0);
				ProcessComplete: out std_logic);
	end component;
	

	
	component SevenSegmentDriver
		port(h3, h2, h1, h0: in std_logic;
			  a, b, c, d, e, f, g: out std_logic);
	end component;
	
	signal tmpBus, tmpRs, tmpRt: std_logic_vector(7 downto 0);
	
begin
	CPU: Simple_CPU
		port map(Data, Control, Clock, tmpBus, tmpRs, tmpRt, Done);
		
	
	HEX1_Bus: SevenSegmentDriver
		port map(tmpBus(7), tmpBus(6), tmpBus(5), tmpBus(4), HEX_Bus(7), HEX_Bus(8), HEX_Bus(9), HEX_Bus(10), HEX_Bus(11), HEX_Bus(12), HEX_Bus(13));
	HEX0_Bus: SevenSegmentDriver
		port map(tmpBus(3), tmpBus(2), tmpBus(1), tmpBus(0), HEX_Bus(0), HEX_Bus(1), HEX_Bus(2), HEX_Bus(3), HEX_Bus(4), HEX_Bus(5), HEX_Bus(6));

	HEX1_Rs: SevenSegmentDriver
		port map(tmpRs(7), tmpRs(6), tmpRs(5), tmpRs(4), HEX_Rs(7), HEX_Rs(8), HEX_Rs(9), HEX_Rs(10), HEX_Rs(11), HEX_Rs(12), HEX_Rs(13));
	HEX0_Rs: SevenSegmentDriver
		port map(tmpRs(3), tmpRs(2), tmpRs(1), tmpRs(0), HEX_Rs(0), HEX_Rs(1), HEX_Rs(2), HEX_Rs(3), HEX_Rs(4), HEX_Rs(5), HEX_Rs(6));
		
	HEX1_Rt: SevenSegmentDriver
		port map(tmpRt(7), tmpRt(6), tmpRt(5), tmpRt(4), HEX_Rt(7), HEX_Rt(8), HEX_Rt(9), HEX_Rt(10), HEX_Rt(11), HEX_Rt(12), HEX_Rt(13));
	HEX0_Rt: SevenSegmentDriver
		port map(tmpRt(3), tmpRt(2), tmpRt(1), tmpRt(0), HEX_Rt(0), HEX_Rt(1), HEX_Rt(2), HEX_Rt(3), HEX_Rt(4), HEX_Rt(5), HEX_Rt(6));
		
end exp7_arch;