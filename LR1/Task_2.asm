	ORG $8000

	TPA
	STAA $8102      

	LDAA #2
	STAA $8100
	LDAB #3
	STAB $8101

	PSHA
	PSHB

	LDAA $8100
	LDAB $8101
	MUL

	STD $8103

	LDAA $8102       
	TAP              

	PULB
	PULA

HERE	BRA	HERE