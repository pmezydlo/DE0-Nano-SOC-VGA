
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA is
  port(clk50_in  : in std_logic;
       red_out   : out std_logic;
       green_out : out std_logic;
       blue_out  : out std_logic;
       hs_out    : out std_logic;
       vs_out    : out std_logic;
		 key0 : in std_logic;
		 key1 : in std_logic);
end VGA;

architecture Behavioral of VGA is

signal clk25              : std_logic;
signal horizontal_counter : std_logic_vector (9 downto 0);
signal vertical_counter   : std_logic_vector (9 downto 0);
signal x : integer := 300;
signal y : integer := 500;
signal x_next : integer := 300;

signal ball_x : integer := 160;
signal ball_y : integer := 150;
signal ball_x_next : integer := 160;
signal ball_y_next : integer := 150;
constant x_v,y_v:integer:=3;-- horizontal and vertical speeds of the ball 

	 signal licznik : integer := 0;
	constant max : integer := 100000;
    signal stan : integer := 1;
	 

begin

-- generate a 25Mhz clock


process (clk50_in)
begin
  if clk50_in'event and clk50_in='1' then
    if (clk25 = '0') then
      clk25 <= '1';
    else
      clk25 <= '0';
    end if;
  end if;
end process;


	
process (clk25)
begin
	
 

  if clk25'event and clk25 = '1' then 
 
  
    if (horizontal_counter >= "0010010000" ) -- 144
    and (horizontal_counter < "1100010000" ) -- 784
    and (vertical_counter >= "0000100111" ) -- 39
    and (vertical_counter < "1000000111" ) -- 519
    then

     --here you paint!!
	  if (horizontal_counter<x+35) and (vertical_counter<y+5) 
	  and (horizontal_counter>x-35) and (vertical_counter>y-5) then
			red_out <= '1';
			green_out <= '0';
			blue_out <= '0';
		elsif (horizontal_counter>144) and (vertical_counter>40) 
	  and (horizontal_counter<774) and (vertical_counter<60) then
	  		red_out <= '0';
			green_out <= '0';
			blue_out <= '1';
			elsif (horizontal_counter<ball_x+5) and (vertical_counter<ball_y+5) 
	  and (horizontal_counter>ball_x-5) and (vertical_counter>ball_y-5) then
	  		red_out <= '1';
			green_out <= '1';
			blue_out <= '0';
			else
			red_out <= '0';
			green_out <= '1';
			blue_out <= '0';
		end if;
		
			  

    else
      red_out <= '0';
      green_out <= '0';
      blue_out <= '0';
    end if;
    if (horizontal_counter > "0000000000" )
      and (horizontal_counter < "0001100001" ) -- 96+1
    then
      hs_out <= '0';
    else
      hs_out <= '1';
    end if;
    if (vertical_counter > "0000000000" )
      and (vertical_counter < "0000000011" ) -- 2+1
    then
      vs_out <= '0';
    else
      vs_out <= '1';
    end if;
    horizontal_counter <= horizontal_counter+"0000000001";
    if (horizontal_counter="1100100000") then
      vertical_counter <= vertical_counter+"0000000001";
      horizontal_counter <= "0000000000";
    end if;
    if (vertical_counter="1000001001") then
      vertical_counter <= "0000000000";
    end if;
  end if;
end process;

process(clk25)
begin
     if clk25'event and clk25='1' then
          x <= x_next;
			 ball_x <= ball_x_next;
			 ball_y <= ball_y_next;
      end if;
end process;

process (clk25)
	  begin 
	    if rising_edge(clk25) then
				if (max=licznik)then
					licznik <= 0;
					
						 if  key0='0' then
							x_next <= x + 1; 
						  end if;
		 
						if  key1='0' then
							x_next <= x - 1;
						end if;	 
						
						  if stan=1 then
						    ball_x_next <= ball_x + 2;
							 ball_y_next <= ball_y + 2;
						  elsif stan=2 then
						  	 ball_x_next <= ball_x + 2;
							 ball_y_next <= ball_y - 2;
						  elsif stan=3 then
						  	 ball_x_next <= ball_x - 2;
							 ball_y_next <= ball_y + 2;
						  elsif stan=4 then
						  	 ball_x_next <= ball_x - 2;
							 ball_y_next <= ball_y - 2;
						  else
						    ball_x_next <= 160;
							 ball_y_next <= 150;
						   end if;
							
							if  stan = 1 and ball_x<760  and ball_y > 500 then
							stan <= 2;
							elsif stan = 2 and ball_x>760  and ball_y < 500 then
							stan <= 4;
							elsif stan = 4 and ball_x<760  and ball_y < 50 then
							stan <= 3;
							elsif stan = 3 and ball_x < 50  and ball_y < 500 then
							stan <= 1;
					
							else
							
							end if;
							
						
						
						
						else
							licznik <= licznik + 1;
				end if;
		  end if;
	  
	  end process;

--	process (key0,key1)
	-- begin
	  
	
	 -- if  key0='0' then
		-- x_next <= x + 1 
		 --end if;
		 
		  --if  key1='0' then
		 --x_next <= x - 1 
		 --end if;	 

	--end process;
	
	
end Behavioral;