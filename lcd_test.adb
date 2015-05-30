with AVR.Real_Time.Delays; -- needed due to delay statement

with LiquidCrystal;

procedure LCD_Test is
   Invader0: LiquidCrystal.Bit_Map := (
                                       2#00000#,
                                       2#00100#,
                                       2#01110#,
                                       2#10101#,
                                       2#11111#,
                                       2#00100#,
                                       2#01010#,
                                       2#10001#);
   Invader1: LiquidCrystal.Bit_Map := (
                                       2#00000#,
                                       2#00100#,
                                       2#01110#,
                                       2#10101#,
                                       2#11111#,
                                       2#01110#,
                                       2#10001#,
                                       2#01010#);
   Counter1 : array (4..15) of Boolean := (others => False);
   Counter2 : array (4..15) of Character := (others => '0');
   I : Integer;
begin
   LiquidCrystal.Init(16, 2);
   LiquidCrystal.Clear;
   LiquidCrystal.Set_Cursor(0, 0);
   LiquidCrystal.Put("Dec:");
   LiquidCrystal.Set_Cursor(0, 1);
   LiquidCrystal.Put("Bin:");
   LiquidCrystal.Create_Char(0, Invader0);
   LiquidCrystal.Create_Char(1, Invader1);
   loop
      I := Counter1'Last;
      while I >= Counter1'First and Counter1(I) loop
         LiquidCrystal.Set_Cursor(LiquidCrystal.Byte(I), 1);
         LiquidCrystal.Put(' ');
         Counter1(I) := False;
         I := I-1;
      end loop;
      if I >= Counter1'First then
	 LiquidCrystal.Set_Cursor(LiquidCrystal.Byte(I), 1);
	 LiquidCrystal.Write(LiquidCrystal.Byte(I mod 2));
	 Counter1(I) := True;
      end if;
      I := Counter2'Last;
      while I >= Counter2'First and Counter2(I) = '9' loop
	 LiquidCrystal.Set_Cursor(LiquidCrystal.Byte(I), 0);
	 LiquidCrystal.Put('0');
	 Counter2(I) := '0';
	 I := I-1;
      end loop;
      if I >= Counter2'First then
	 LiquidCrystal.Set_Cursor(LiquidCrystal.Byte(I), 0);
	 Counter2(I) := Character'Succ(Counter2(I));
	 LiquidCrystal.Put(Counter2(I));
      end if;
      delay 1.0;
   end loop;
end LCD_Test;
