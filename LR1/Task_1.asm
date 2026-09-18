	ORG $8000
	
	LDX #1
	LDY #2

	XGDX
	XGDY
	XGDX

	PSHX
	PSHY
	PULX
	PULY

        STX $8100
        STY $8102
        LDX $8102
        LDY $8100

HERE	BRA	HERE

