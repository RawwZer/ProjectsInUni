program �������;
{
  Dividing two numbers (around 255 digit in each)
}

uses
  System.SysUtils;

var
  Num_1, Num_2, Rez: shortstring;
  K, N, I, j, Count: smallint;
  L, Stop: boolean;
  ArrayOfDiv: array [1 .. 256] of shortint;
  // Num_1, Num_2 - numbers, which must be added
  // I, J, Border - auxiliary variables for counting
  // RunkOfNumber - intermediate value of n-digit addition of numbers
  // Z - variable of sign of number
  // ArrayOfSum - array to add Num_1 and Num_2
  // L - variable to check for errors

const
  LengthA = length(ArrayOfDiv);
  // LengthA - Length ArrayOfSum

begin

  Repeat
    Write('������� ������ �����: ');
    readln(Num_1);
    // Requiring the second number
    Write('������� ������ �����: ');
    readln(Num_2);

    j := length(Num_1);
    Try
      Begin
        // Inicialization from last digit to the first
        // to array element from the end of it
        for I := LengthA downto (LengthA - length(Num_1) + 1) do
        Begin
          ArrayOfDiv[I] := StrToInt(Num_1[j]);

          j := j - 1;
        End;
        L := true;
      End;
    except
      on e: EConvertError do
      begin
        Writeln('�� ����� �� �����! ��������� �������!');

        L := False;
      end;

    End;
  Until L;

  if length(Num_1) < length(Num_2) then
    Rez := '0.';

  N := 0;
  Repeat

    j := length(Num_2);
    I := LengthA - length(Num_1) + length(Num_2) + N;
    Stop := False;
    // Substraction
    repeat
      // If we need to get a rank from the next one
      If ArrayOfDiv[I] < StrToInt(Num_2[j]) then
        // if the next on is zero and we again need a rank
        if ArrayOfDiv[I - 1] = 0 then
        Begin
          // Trying to find the rank, which isn't zero
          while (ArrayOfDiv[I - K] <= 0) and
            ((LengthA - I + K + 2) <= length(Num_2)) do
          Begin
            K := K + 1;
            ArrayOfDiv[I - K] := ArrayOfDiv[I - K] - 1;
            ArrayOfDiv[I + 1 - K] := ArrayOfDiv[I + 1 - K] + 10;
          End;
        End
        Else
        Begin

          // Getting a rank from the next one and
          // substracting it
          ArrayOfDiv[I - 1] := ArrayOfDiv[I - 1] - 1;
          ArrayOfDiv[I] := ArrayOfDiv[I] + 10;
        End;

      if (ArrayOfDiv[I] - StrToInt(Num_2[j])) < 0 then
        Stop := true
      Else
      Begin
        ArrayOfDiv[I] := ArrayOfDiv[I] - StrToInt(Num_2[j]);
        if j = 1 then
          Count := Count + 1;
      End;

      if length(Num_2) > 1 then
      Begin
        j := j - 1;
        I := I - 1;
      End;

      K := 0;

    Until Stop or (j = 0);

    if not((Rez = '') and (Count = 0)) then
    begin
      insert(IntToStr(Count), Rez, length(Rez) + 1);
      Count := 0;
    end;

    N := N + 1;
    j := length(Num_2);
    I := LengthA - length(Num_1) + length(Num_2) + N;
    Stop := False;

  Until I > LengthA;

  Write('������� ����� ', Num_1, ' � ', Num_2);

  if Rez = '' then
    Writeln('�� ����������')
  else
  Begin

    // Finding a border of length of the sum
    If length(Num_2) > length(Num_1) then
      j := (LengthA - length(Num_2)) - 1
    Else
      j := (LengthA - length(Num_1)) - 1;

    While (ArrayOfDiv[j] = 0) and (j < LengthA) do
      j := j + 1;

    if (j <= LengthA) and (ArrayOfDiv[j] = 0) then
      Writeln(' ����� ', Rez)
    Else
    Begin
      Writeln(' (��������) ����� ', Rez);
      write('������� ����� ');
      // Outputting the sum
      for I := j to LengthA do
        Write(ArrayOfDiv[I]);
    End;

  End;

  readln;

end.
