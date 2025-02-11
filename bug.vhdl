In VHDL, a subtle error can occur when using generics with signals or variables that are not directly connected to the entity's ports.  If a generic is used to define the size of an array or other data structure within a process, and that process modifies the data structure without appropriate signal updates, race conditions or incorrect behavior might arise.  This is because the generic's value may not be correctly reflected during simulation or synthesis. This often manifests as unexpected values or simulation mismatches.

Example:

```vhdl
entity my_entity is
  generic (DATA_WIDTH : integer := 8);
  port (clk : in std_logic;
        data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_logic_vector(DATA_WIDTH-1 downto 0));
end entity;

architecture behavioral of my_entity is
  signal data_reg : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
begin
  process (clk)
  begin
    if rising_edge(clk) then
      -- Incorrect: data_reg is not directly connected to the port, could lead to race conditions if DATA_WIDTH changes
      data_reg <= data_in; 
      data_out <= data_reg;
    end if;
  end process;
end architecture;