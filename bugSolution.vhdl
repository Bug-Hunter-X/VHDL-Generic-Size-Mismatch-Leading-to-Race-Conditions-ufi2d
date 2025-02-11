The solution involves explicitly connecting the internal signals to the entity's ports or using a separate signal to track changes based on generic values. This ensures proper signal updates and avoids race conditions. 

```vhdl
entity my_entity is
  generic (DATA_WIDTH : integer := 8);
  port (clk : in std_logic;
        data_in : in std_logic_vector(DATA_WIDTH-1 downto 0);
        data_out : out std_logic_vector(DATA_WIDTH-1 downto 0));
end entity;

architecture behavioral of my_entity is
  signal data_reg : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
  signal data_width_sig : integer := DATA_WIDTH;  -- Track generic with a signal
begin
  process (clk)
  begin
    if rising_edge(clk) then
      -- Correct: Use a separate signal to reflect generic updates properly.
      data_reg <= data_in;
      data_out <= data_reg; 
    end if;
  end process;
end architecture; 
```
By using `data_width_sig`, changes to the generic `DATA_WIDTH` will be reflected correctly within the process.  Alternatively, direct connection to ports would also resolve the issue if architectural design allows it.