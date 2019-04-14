

	.FUNCT	CELL-OBJECT-F
	EQUAL?	PRSA,V?WALK-TO,V?BOARD,V?ENTER \?ELS5
	CALL	ADJ-USED,A?OTHER
	ZERO?	STACK \?THN11
	CALL	ADJ-USED,A?SMALL
	ZERO?	STACK /?ELS10
?THN11:	EQUAL?	HERE,OTHER-CELL \?ELS17
	PRINT	LOOK-AROUND
	RTRUE	
?ELS17:	EQUAL?	HERE,END-OF-HALLWAY \?ELS19
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS19:	PRINT	CANT-FROM-HERE
	RTRUE	
?ELS10:	EQUAL?	HERE,CELL \?ELS23
	PRINT	LOOK-AROUND
	RTRUE	
?ELS23:	EQUAL?	HERE,END-OF-HALLWAY \?ELS25
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS25:	PRINT	CANT-FROM-HERE
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \?ELS29
	CALL	ADJ-USED,A?OTHER
	ZERO?	STACK \?THN35
	CALL	ADJ-USED,A?SMALL
	ZERO?	STACK /?ELS34
?THN35:	EQUAL?	HERE,OTHER-CELL \?ELS41
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS41:	PRINT	LOOK-AROUND
	RTRUE	
?ELS34:	EQUAL?	HERE,CELL \?ELS45
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS45:	EQUAL?	HERE,OTHER-CELL \?ELS47
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS47:	PRINT	LOOK-AROUND
	RTRUE	
?ELS29:	EQUAL?	PRSA,V?EXAMINE \?ELS51
	EQUAL?	HERE,END-OF-HALLWAY /?ELS51
	CALL	V-LOOK
	RSTACK	
?ELS51:	EQUAL?	PRSA,V?CLOSE,V?OPEN,V?LOOK-INSIDE \?ELS55
	EQUAL?	HERE,END-OF-HALLWAY \?ELS58
	CALL	ADJ-USED,A?OTHER
	ZERO?	STACK \?THN62
	CALL	ADJ-USED,A?SMALL
	ZERO?	STACK /?ELS61
?THN62:	CALL	PERFORM-PRSA,NARROW-CELL-DOOR
	RTRUE	
?ELS61:	CALL	PERFORM-PRSA,WIDE-CELL-DOOR
	RTRUE	
?ELS58:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS67
	CALL	V-LOOK
	RTRUE	
?ELS67:	EQUAL?	HERE,CELL \?ELS69
	CALL	PERFORM-PRSA,WIDE-CELL-DOOR
	RTRUE	
?ELS69:	CALL	PERFORM-PRSA,NARROW-CELL-DOOR
	RTRUE	
?ELS55:	EQUAL?	PRSA,V?PUT \?ELS73
	EQUAL?	PRSI,CELL-OBJECT \?ELS73
	EQUAL?	HERE,END-OF-HALLWAY \?ELS80
	PRINT	CANT-FROM-HERE
	RTRUE	
?ELS80:	CALL	PERFORM,V?DROP,PRSO
	RTRUE	
?ELS73:	EQUAL?	HERE,END-OF-HALLWAY /FALSE
	EQUAL?	PRSO,CELL-OBJECT \FALSE
	CALL	PERFORM-PRSA,GLOBAL-ROOM,PRSI
	RTRUE	


	.FUNCT	CELL-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are in a large cell with a soft, cushiony floor. A wide door ("
	FSET?	WIDE-CELL-DOOR,OPENBIT \?ELS8
	PRINTI	"now open"
	JUMP	?CND6
?ELS8:	FSET?	WIDE-CELL-DOOR,TOUCHBIT \?ELS10
	PRINTI	"now closed"
	JUMP	?CND6
?ELS10:	PRINTI	"closed, naturally"
?CND6:	PRINTI	") forms the southern wall of the cell"
	ZERO?	HOLE-OPEN /?CND13
	PRINTI	". A "
	CALL	DPRINT,HOLE
	PRINTI	" is lying on the ground amidst some rubble"
?CND13:	PRINTI	"."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \?ELS18
	ZERO?	TRAY-DELIVERED \?ELS18
	SET	'TRAY-DELIVERED,TRUE-VALUE
	MOVE	TRAY,HERE
	PRINTI	"   Someone thrusts a tray into your cell. A "
	CALL	DPRINT,CHOCOLATE
	PRINTI	" on the tray"
	PRINT	LOOKS-UNAPPETIZING
	RTRUE	
?ELS18:	EQUAL?	RARG,M-END \FALSE
	IN?	SIDEKICK,HERE \FALSE
	ZERO?	CELL-GRIPE \FALSE
	SET	'CELL-GRIPE,TRUE-VALUE
	PRINTI	"   ""What a great cell!"" says "
	CALL	DPRINT-SIDEKICK
	PRINTI	", looking around. ""Why didn't I get a cell like this? Maybe I shouldn't have kicked that guard "
	EQUAL?	NAUGHTY-LEVEL,1 \?ELS27
	PRINTI	"below the waist "
	JUMP	?CND25
?ELS27:	EQUAL?	NAUGHTY-LEVEL,2 \?CND25
	PRINTI	"in the nuts "
?CND25:	PRINTR	"when I first got here..."""


	.FUNCT	HOLE-ENTER-F
	ZERO?	HOLE-OPEN /?ELS3
	PRINT	YOU-CANT
	PRINTI	"reach the hole in the ceiling."
	CRLF	
	RFALSE	
?ELS3:	PRINT	CANT-GO
	RFALSE	


	.FUNCT	BLANKET-F
	FSET?	BLANKET,UNTEEDBIT /FALSE
	EQUAL?	PRSA,V?MEASURE \?ELS7
	PRINTR	"Small."
?ELS7:	EQUAL?	PRSA,V?WEAR /?THN10
	EQUAL?	PRSA,V?WRAP \?ELS9
	EQUAL?	PRSI,ME \?ELS9
?THN10:	PRINTR	"It's too small; your jailors must have meant it to be used as a pillow."
?ELS9:	EQUAL?	PRSA,V?BOARD \?ELS15
	CALL	WASTES
	RSTACK	
?ELS15:	EQUAL?	PRSA,V?TIE \?ELS17
	PRINTR	"The material of the blanket is too thick to knot."
?ELS17:	EQUAL?	PRSA,V?TAKE,V?REMOVE \?ELS19
	IN?	BLANKET,BABY \?ELS19
	CALL	PERFORM,V?REMOVE,BABY
	RTRUE	
?ELS19:	EQUAL?	PRSA,V?PUT \?ELS23
	EQUAL?	PRSI,BASKET \?ELS23
	IN?	BLANKET,BABY \?ELS30
	CALL	PERFORM-PRSA,BABY,BASKET
	RTRUE	
?ELS30:	IN?	BABY,BASKET \FALSE
	MOVE	BLANKET,BASKET
	MOVE	BABY,PROTAGONIST
	CALL	PERFORM-PRSA,BABY,BASKET
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?THROW,V?PUT,V?DROP \?ELS34
	EQUAL?	PRSO,BLANKET \?ELS34
	IN?	BLANKET,BABY \?ELS34
	CALL	DO-FIRST,STR?398
	RSTACK	
?ELS34:	EQUAL?	PRSA,V?LOOK-INSIDE \?ELS38
	IN?	BLANKET,BABY \?ELS38
	CALL	PERFORM,V?ALARM,BABY
	RTRUE	
?ELS38:	EQUAL?	PRSA,V?PUT-ON \FALSE
	EQUAL?	PRSO,BLANKET \FALSE
	FSET?	PRSI,SURFACEBIT /FALSE
	CALL	WASTES
	RSTACK	


	.FUNCT	PAINTING-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	PAINTING,UNTEEDBIT /FALSE
	SET	'AWAITING-REPLY,2
	CALL	QUEUE,I-REPLY,2
	PRINTR	"It's a good likeness of a pussy, but is it art?"


	.FUNCT	TRAY-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET?	TRAY,UNTEEDBIT \FALSE
	PRINTR	"It looks a little like Ray whatsisname from second grade."


	.FUNCT	CHOCOLATE-F
	FSET?	CHOCOLATE,UNTEEDBIT /FALSE
	EQUAL?	PRSA,V?EAT \?ELS7
	CALL	ULTIMATELY-IN?,CHOCOLATE
	ZERO?	STACK \?CND8
	PRINT	YNH
	PRINTR	" it!"
?CND8:	REMOVE	CHOCOLATE
	CALL	QUEUE,I-UNRUSH,6
	ZERO?	GONE-APE /?ELS13
	SET	'SUGAR-RUSH,GORILLA-ATE-CHOCOLATE
	JUMP	?CND11
?ELS13:	SET	'SUGAR-RUSH,HUMAN-ATE-CHOCOLATE
?CND11:	PRINTI	"Mmmm! "
	ZERO?	CHOCOLATE-IDENTIFIED /?ELS19
	PRINTI	"G"
	JUMP	?CND17
?ELS19:	PRINTI	"It's a piece of really g"
?CND17:	PRINTR	"ood chocolate! You feel yourself getting a sugar rush."
?ELS7:	EQUAL?	PRSA,V?EXAMINE \?ELS24
	PRINTI	"The "
	CALL	DPRINT,CHOCOLATE
	PRINT	LOOKS-UNAPPETIZING
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?TASTE \?ELS26
	SET	'CHOCOLATE-IDENTIFIED,TRUE-VALUE
	PUTP	CHOCOLATE,P?SDESC,STR?404
	RFALSE	
?ELS26:	EQUAL?	PRSA,V?SMELL \FALSE
	FSET?	CHOCOLATE,SMELLEDBIT /FALSE
	SET	'CHOCOLATE-IDENTIFIED,TRUE-VALUE
	FSET	CHOCOLATE,SMELLEDBIT
	PUTP	CHOCOLATE,P?SDESC,STR?404
	CALL	SCRATCH-N-SNIFF,2
	PRINTR	"Luscious, creamy milk chocolate!"


	.FUNCT	I-UNRUSH
	ZERO?	GONE-APE /?ELS9
	EQUAL?	SUGAR-RUSH,GORILLA-ATE-CHOCOLATE /?THN6
?ELS9:	ZERO?	GONE-APE \?ELS5
	EQUAL?	SUGAR-RUSH,HUMAN-ATE-CHOCOLATE \?ELS5
?THN6:	SET	'SUGAR-RUSH,FALSE-VALUE
	PRINTR	"   You feel the sugar rush ebb."
?ELS5:	SET	'SUGAR-RUSH,FALSE-VALUE
	RFALSE	


	.FUNCT	OTHER-CELL-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	FSET?	OTHER-CELL,TOUCHBIT /?ELS5
	CALL	THIS-IS-IT,SIDEKICK
	CALL	QUEUE,I-BLUEPRINT,19
	ZERO?	VERBOSITY /FALSE
	PRINTI	"As you enter, a "
	ZERO?	MALE \?CND11
	PRINTI	"wo"
?CND11:	PRINTI	"man sitting limply in the shadows stiffens and rises to "
	CALL	HIS-HER
	PRINTI	" feet. ""A human! They got you too? I've been here a week. When you opened the door, I figured it was a guard! Was it unlocked? I never thought of trying it. By the way, my name's "
	CALL	DPRINT-SIDEKICK
	PRINTI	". From Alaska. I'm not too bright, but I'm strong as an ox, and I'm great with my hands. Maybe we can lick these Leather Goddesses together."""
	CRLF	
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a very tiny room with a rock-hard floor. A "
	PRINTD	NARROW-CELL-DOOR
	PRINTI	" to the north is "
	CALL	OPEN-CLOSED,NARROW-CELL-DOOR
	PRINTI	"."
	RTRUE	


	.FUNCT	NARROW-CELL-DOOR-F
	EQUAL?	PRSA,V?KNOCK \FALSE
	IN?	SIDEKICK,OTHER-CELL \FALSE
	PRINTR	"A muffled voice responds, ""Beat it, you alien fruitcake freako mutant weirdo scum!"""


	.FUNCT	SIDEKICK-F,OARG=0
	ZERO?	OARG /?ELS5
	EQUAL?	OARG,M-OBJDESC? /TRUE
	PRINTI	"   "
	CALL	DPRINT-SIDEKICK
	PRINTI	" is here, "
	CALL	SIDEKICK-DESC
	PRINTI	"."
	RTRUE	
?ELS5:	EQUAL?	SIDEKICK,WINNER \?ELS11
	EQUAL?	PRSA,V?WHAT \?ELS16
	CALL	PERFORM,V?TELL-ABOUT,ME,PRSO
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?READ \?ELS18
	EQUAL?	PRSO,SCRAP-OF-PAPER \?ELS18
	CALL	PERFORM,V?TELL-ABOUT,ME,SCRAP-OF-PAPER
	RTRUE	
?ELS18:	EQUAL?	PRSA,V?TELL-ABOUT \?ELS22
	EQUAL?	PRSO,ME \?ELS22
	EQUAL?	PRSI,ODD-MACHINE \?ELS29
	IN?	ODD-MACHINE,SALESMAN /?ELS29
	PRINTR	"""Hmmm, tee remover. For cleaning up golf courses?"""
?ELS29:	EQUAL?	PRSI,SCRAP-OF-PAPER \?ELS33
	PRINTR	"""I dunno what it means; I doodled it one night in my sleep!"""
?ELS33:	EQUAL?	PRSI,MATCHBOOK \?ELS35
	CALL	QUEUED?,I-BLUEPRINT
	ZERO?	STACK \?ELS35
	CALL	SCRAPE-UP-THESE-ITEMS
	RSTACK	
?ELS35:	EQUAL?	PRSI,LGOP \?ELS39
	PRINTR	"""No doubt some gang of interplanetary floozies who get their jollies from enslaving defenseless planets. We'll stop 'em!"""
?ELS39:	CALL	DPRINT-SIDEKICK
	PRINTI	" shrugs. ""What do I know? I'm from Alaska,"" "
	CALL	HE-SHE
	PRINTR	" says, in a burst of insecurity that will no doubt ease in a quarter-century or so when Alaska becomes a state."
?ELS22:	EQUAL?	PRSA,V?WALK \?ELS43
	PRINTR	"""After you!"""
?ELS43:	EQUAL?	PRSA,V?FOLLOW \?ELS45
	EQUAL?	PRSO,ME \?ELS45
	PRINTR	"""Lead on!"""
?ELS45:	EQUAL?	PRSA,V?HELLO \?ELS49
	PRINTR	"""Hi!"""
?ELS49:	EQUAL?	PRSA,V?EXIT,V?ENTER,V?DISEMBARK \?ELS51
	EQUAL?	PRSO,WINDOW \?ELS51
	EQUAL?	HERE,BEDROOM \?ELS51
	ZERO?	SIDEKICK-TRIP-FLAG /?ELS58
	PRINTR	"""Not again!"""
?ELS58:	CALL	QUEUED?,I-SIDEKICK-OUT-WINDOW
	ZERO?	STACK /?ELS61
	PRINTR	"""Gimme a second to get ready!"""
?ELS61:	PRINTR	"""I'm dumb, but not that dumb!"""
?ELS51:	EQUAL?	PRSA,V?KISS \?ELS65
	EQUAL?	PRSO,FROG \?ELS65
	PRINTR	"""I'd sooner kiss a pig!"""
?ELS65:	EQUAL?	PRSA,V?RAISE \?ELS69
	EQUAL?	PRSO,ME \?ELS69
	LOC	PROTAGONIST
	EQUAL?	STACK,TREE-HOLE,CLOSET \?ELS69
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?CLIMB-ON,SIDEKICK
	SET	'WINNER,SIDEKICK
	RTRUE	
?ELS69:	EQUAL?	PRSA,V?TAKE \?ELS73
	EQUAL?	PRSO,HEADLIGHT \?ELS73
	FSET?	HEADLIGHT,TRYTAKEBIT \?ELS73
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?SHOW,HEADLIGHT,SIDEKICK
	SET	'WINNER,SIDEKICK
	RTRUE	
?ELS73:	EQUAL?	PRSA,V?GIVE \?ELS77
	EQUAL?	PRSI,ME \?ELS77
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?ASK-FOR,SIDEKICK,PRSO
	SET	'WINNER,SIDEKICK
	RTRUE	
?ELS77:	EQUAL?	PRSA,V?SGIVE /FALSE
	EQUAL?	PRSA,V?MAKE \?ELS83
	EQUAL?	PRSO,ANTI-LGOP-MACHINE \?ELS83
	PRINTR	"""Don't crowd me."""
?ELS83:	CALL	DPRINT-SIDEKICK
	PRINTI	" is "
	CALL	SIDEKICK-DESC
	PRINTI	" and fails to notice that you've spoken."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS11:	CALL	WRONG-SEX-WORD,SIDEKICK,W?TRENT,W?TIFFAN
	ZERO?	STACK /?ELS89
	CALL	STOP
	RSTACK	
?ELS89:	CALL	WRONG-SEX-WORD,SIDEKICK,W?TRENT,W?TIFF
	ZERO?	STACK /?ELS91
	CALL	STOP
	RSTACK	
?ELS91:	EQUAL?	PRSA,V?EXAMINE \?ELS93
	CALL	DPRINT-SIDEKICK
	PRINTI	" is about your age"
	ZERO?	NAUGHTY-LEVEL /?CND94
	PRINTI	" and has a body worthy of envy: tall and well-built, with wide shoulders, "
	ZERO?	MALE /?ELS99
	PRINTI	"massive pectorals, and thick"
	JUMP	?CND97
?ELS99:	PRINTI	"a generous bosom, slim waist, and long"
?CND97:	PRINTI	", tawny legs. The only minus seems to be slightly oversized feet, but even oversized feet are a plus if you're into toe-sucking"
?CND94:	PRINTI	"."
	FIRST?	SIDEKICK \?ELS107
	PRINTI	" "
	RFALSE	
?ELS107:	CRLF	
	RTRUE	
?ELS93:	EQUAL?	PRSA,V?ASK-FOR \?ELS111
	EQUAL?	PRSO,SIDEKICK \?ELS111
	CALL	ULTIMATELY-IN?,PRSI,SIDEKICK
	ZERO?	STACK /?ELS118
	MOVE	PRSI,PROTAGONIST
	PRINTR	"""What's mine is yours!"""
?ELS118:	PRINTI	"""I haven't got"
	CALL	APRINT,PRSI
	PRINTR	"!"""
?ELS111:	EQUAL?	PRSA,V?FOLLOW \?ELS122
	EQUAL?	FOLLOW-FLAG,1 \?ELS127
	CALL	PERFORM,V?CLIMB-DOWN,SHEET
	RTRUE	
?ELS127:	EQUAL?	FOLLOW-FLAG,2 \?ELS129
	PRINT	DONT-WANT-TO
	RTRUE	
?ELS129:	EQUAL?	FOLLOW-FLAG,3 \FALSE
	CALL	PERFORM,V?ENTER,CANAL-OBJECT
	RTRUE	
?ELS122:	EQUAL?	PRSA,V?UNTIE \?ELS133
	CALL	PERFORM-PRSA,SIDEKICKS-BODY
	RTRUE	
?ELS133:	EQUAL?	PRSA,V?TIE \?ELS135
	EQUAL?	PRSI,SECOND-SLAB,FIRST-SLAB \?ELS135
	CALL	PERFORM-PRSA,SIDEKICKS-BODY
	RTRUE	
?ELS135:	EQUAL?	PRSA,V?STAND-ON,V?BOARD,V?CLIMB-ON \?ELS139
	IN?	PROTAGONIST,TREE-HOLE /?THN145
	EQUAL?	HERE,CLOSET \?ELS144
	FIRST?	SHELF \?ELS144
?THN145:	PRINTI	"Using "
	CALL	DPRINT-SIDEKICK
	PRINTI	"'s shoulders, you "
	IN?	PROTAGONIST,TREE-HOLE \?ELS151
	MOVE	PROTAGONIST,HERE
	MOVE	SIDEKICK,HERE
	PRINTI	"climb out of the hole and help "
	CALL	DPRINT-SIDEKICK
	PRINTI	" out"
	JUMP	?CND149
?ELS151:	CALL	ROB,SHELF,PROTAGONIST
	PRINTI	"get everything from the shelf"
?CND149:	PRINT	PERIOD-CR
	RTRUE	
?ELS144:	CALL	WASTES
	RSTACK	
?ELS139:	EQUAL?	PRSA,V?PUSH \?ELS157
	EQUAL?	PRSI,TREE-HOLE \?ELS157
	CALL	DPRINT-SIDEKICK
	PRINTI	" grabs wildly at you, pulling both of you into the hole"
	FSET?	TRELLIS,MUNGBIT \?CND160
	ZERO?	LEAVES-PLACED /?CND163
	MOVE	LEAVES,TREE-HOLE
?CND163:	REMOVE	TRELLIS
	CALL	UNDO-TRAP
	PRINTI	" with a crash of splintering wood"
?CND160:	PRINTI	". "
	IN?	FLYTRAP,TREE-HOLE \?ELS171
	CALL	PERFORM,V?ENTER,TREE-HOLE
	RTRUE	
?ELS171:	MOVE	PROTAGONIST,TREE-HOLE
	MOVE	SIDEKICK,TREE-HOLE
	IN?	TRELLIS,PROTAGONIST \?CND174
	MOVE	TRELLIS,HERE
?CND174:	PRINTI	"""Brilliant move, bozo,"" says "
	CALL	DPRINT-SIDEKICK
	PRINT	PERIOD-CR
	RTRUE	
?ELS157:	EQUAL?	PRSA,V?GIVE \?ELS178
	EQUAL?	HERE,PLAZA \?ELS178
	SUB	PLAZA-COUNTER,1
	GET	PARTS-LIST,STACK
	EQUAL?	PRSO,STACK \?ELS183
	FSET?	PRSO,UNTEEDBIT /?ELS183
	REMOVE	PRSO
	SET	'RIGHT-PART,TRUE-VALUE
	CALL	DPRINT-SIDEKICK
	PRINTI	" grabs"
	CALL	TPRINT-PRSO
	PRINTI	" and quickly incorporates it into "
	CALL	HIS-HER
	PRINTI	" contraption."
	CRLF	
	RETURN	8
?ELS183:	CALL	DPRINT-SIDEKICK
	PRINTI	" gives"
	CALL	TPRINT-PRSO
	PRINTI	" the barest glance. ""No good! It has to be a"
	CALL	PRINT-PART
	PRINTI	"!"""
	CRLF	
	RETURN	8
?ELS178:	EQUAL?	PRSA,V?GIVE \?ELS191
	CALL	ZMEMQ,PRSO,PARTS-LIST,7
	ZERO?	STACK /?ELS191
	FSET?	PRSO,UNTEEDBIT /?ELS191
	CALL	EAGERLY-ACCEPTS
	PRINT	PERIOD-CR
	RTRUE	
?ELS191:	EQUAL?	PRSA,V?SHOW \FALSE
	EQUAL?	PRSO,HEADLIGHT \?ELS200
	FSET?	HEADLIGHT,TRYTAKEBIT \?ELS200
	PRINTR	"""Can't reach it from here!"""
?ELS200:	EQUAL?	PRSO,SCRAP-OF-PAPER \?ELS204
	CALL	PERFORM,V?ASK-ABOUT,SIDEKICK,SCRAP-OF-PAPER
	RTRUE	
?ELS204:	CALL	ZMEMQ,PRSO,PARTS-LIST,7
	ZERO?	STACK /FALSE
	FSET?	PRSO,UNTEEDBIT /FALSE
	PRINTI	"""Hey, wow!"" says "
	CALL	DPRINT-SIDEKICK
	PRINTI	", clearly impressed by your discovery of"
	CALL	TRPRINT,PRSO
	RSTACK	


	.FUNCT	SIDEKICK-DESC
	GRTR?	PLAZA-COUNTER,0 \?ELS5
	PRINTI	"busy with"
	CALL	TPRINT,ANTI-LGOP-MACHINE
	RSTACK	
?ELS5:	EQUAL?	HERE,BOUDOIR \?ELS7
	PRINTI	"lying on another couch"
	RTRUE	
?ELS7:	RANDOM	100
	LESS?	33,STACK /?ELS9
	PRINTI	"alertly surveying your surroundings"
	RTRUE	
?ELS9:	RANDOM	100
	LESS?	50,STACK /?ELS11
	ZERO?	SIDEKICKS-BODY-TIED-TO-SLAB \?ELS11
	PRINTI	"doing some quick limbering exercises"
	RTRUE	
?ELS11:	PRINTI	"counting on "
	CALL	HIS-HER
	PRINTI	" fingers and mumbling to "
	CALL	HIM-HER
	PRINTI	"self"
	RTRUE	


	.FUNCT	GENERIC-SIDEKICK-F
	GET	P-NAMW,0
	EQUAL?	STACK,W?BODY /FALSE
	GET	P-NAMW,1
	EQUAL?	STACK,W?BODY /FALSE
	RETURN	SIDEKICK


	.FUNCT	MEMORIAM
	PRINTI	", "
	PRINTD	EYES
	PRINTI	" fill with tears. You hang "
	PRINTD	HEAD
	PRINTI	" in sorrow for a moment to honor your brave, loyal companion who gave "
	CALL	HIS-HER
	PRINTI	" life that humanity might be safe from the terrible scourge of "
	PRINTD	LGOP
	PRINT	PERIOD-CR
	RTRUE	


	.FUNCT	CRAMPED-SPACE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	ZERO?	HOLE-OPEN \?ELS5
	CALL	QUEUE,I-CRAMPED-SPACE,2
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in a dark space, too tiny to move around in. The"
	ZERO?	HOLE-OPEN /?ELS14
	PRINTI	" only exit is a hole in the floor."
	RTRUE	
?ELS14:	PRINTI	"re are no visible exits."
	RTRUE	


	.FUNCT	I-CRAMPED-SPACE
	PRINTI	"   Suddenly, part of the floor collapses, and you"
	CALL	AND-SIDEKICK
	PRINTI	" tumble through the resulting hole"
	PRINT	ELLIPSIS
	CALL	GOTO,CELL,TRUE-VALUE
	IN?	SIDEKICK,CRAMPED-SPACE \?CND1
	MOVE	SIDEKICK,HERE
?CND1:	SET	'HOLE-OPEN,TRUE-VALUE
	FCLEAR	CRAMPED-SPACE,TOUCHBIT
	PRINTI	"   Among the new rubble, you notice"
	CALL	APRINT,HOLE
	PRINTI	", attached to a piece of (what used to be) the floor of the cramped space."
	CRLF	
	CALL	CELL-F,M-END
	RTRUE	


	.FUNCT	CRAMPED-SPACE-HOLE-F
	ZERO?	HOLE-OPEN \?ELS5
	CALL	CANT-SEE,PSEUDO-OBJECT
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?ENTER,V?STAND-ON,V?CLIMB-DOWN /?THN8
	EQUAL?	PRSA,V?BOARD \FALSE
?THN8:	CALL	DO-WALK,P?DOWN
	RSTACK	


	.FUNCT	END-OF-HALLWAY-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"A "
	PRINTD	WIDE-CELL-DOOR
	PRINTI	" lies "
	CALL	OPEN-CLOSED,WIDE-CELL-DOOR
	PRINTI	" to the north, and"
	CALL	APRINT,NARROW-CELL-DOOR
	PRINTI	" lies "
	CALL	OPEN-CLOSED,NARROW-CELL-DOOR
	PRINTI	" to the south. The hallway ends at a gleaming "
	PRINTD	EXAM-ROOM-DOOR
	PRINTI	" to the west, and continues east. Something, possibly this very sentence, tells you that it would be dangerous to travel east or west"
	PRINT	SIGN-AND-STAIRS
	RTRUE	


	.FUNCT	EXAMINATION-ROOM-DESC,VIEWING=0
	PRINTI	"A number of hideous experiments fill th"
	ZERO?	VIEWING /?ELS3
	PRINTI	"e"
	JUMP	?CND1
?ELS3:	PRINTI	"is"
?CND1:	PRINTI	" room. Their obvious purpose: studies of the human anatomy"
	EQUAL?	NAUGHTY-LEVEL,1 /?CND7
	PRINTI	", especially those parts rarely referred to in the New York Times"
?CND7:	PRINTI	". A pathetic-looking human is the current subject; however, even an author as fond of lascivious detail as this one would hesitate to describe it "
	EQUAL?	NAUGHTY-LEVEL,2 \?ELS14
	PRINTR	"even in LEWD mode, except to mention that it involves a lot of lubricants, some plastic tubing, and a yak."
?ELS14:	PRINTI	"to someone who's merely in "
	ZERO?	NAUGHTY-LEVEL \?ELS19
	PRINTI	"TAME"
	JUMP	?CND17
?ELS19:	PRINTI	"SUGGESTIVE"
?CND17:	PRINTR	" mode."


	.FUNCT	EXAMINATION-ROOM-F
	FSET?	EXAM-ROOM-DOOR,OPENBIT \?ELS5
	PRINTI	"""Examination"" Room
   "
	ZERO?	SEEN-EXAMINATION-ROOM /?ELS8
	PRINTI	"The experiments look even more horrible from here than from the Observation Room window."
	CRLF	
	JUMP	?CND6
?ELS8:	CALL	EXAMINATION-ROOM-DESC
?CND6:	PRINTI	"   Before you've really gotten as sick as you know you could get, one of the"
	CALL	LECKBANDI
	RSTACK	
?ELS5:	CALL	THIS-IS-IT,EXAM-ROOM-DOOR
	CALL	DO-FIRST,STR?66,EXAM-ROOM-DOOR
	RFALSE	


	.FUNCT	OTHER-END-OF-HALLWAY-F
	PRINTI	"Other End of Hallway
   Before you can even begin to wonder what happened to the middle of the hallway, a guard patrol erupts from the shadows. A"
	CALL	LECKBANDI
	RSTACK	


	.FUNCT	LECKBANDI
	CALL	JIGS-UP,STR?407
	RSTACK	


	.FUNCT	OBSERVATION-ROOM-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Calvin Coolidge once described windows as ""rectangles of glass."" If so, he may have been thinking about the window which fills the western wall of this room. A tiny closet lies to the north"
	PRINT	SIGN-AND-STAIRS
	RTRUE	


	.FUNCT	CLOSET-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This room is barely large enough to turn around in. Just to prove it, you turn around. As you do, you spot"
	CALL	APRINT,HOLE
	PRINTI	", about two feet across, seemingly painted on the floor in the corner. A shelf protrudes from one wall, very close to the ceiling. The closet is open to the south."
	FSET?	NOSE,MUNGBIT /TRUE
	PRINTI	" A strong odor "
	FSET?	HERE,SMELLEDBIT \?CND9
	PRINTI	"of "
	PRINTD	MOTHBALLS
	PRINTI	" "
?CND9:	PRINTI	"pervades the closet."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-SMELL \FALSE
	PRINTI	"Apparently this section of Phobos has a significant moth problem."
	RTRUE	


	.FUNCT	CLOSET-EXIT-F
	PRINTI	"Ah! Coming out of the closet, I see"
	PRINT	ELLIPSIS
	RETURN	OBSERVATION-ROOM


	.FUNCT	CLOSET-OBJECT-F
	EQUAL?	PRSA,V?BOARD,V?WALK-TO,V?ENTER \?ELS5
	EQUAL?	HERE,CLOSET \?ELS10
	PRINT	LOOK-AROUND
	RTRUE	
?ELS10:	EQUAL?	HERE,OBSERVATION-ROOM \FALSE
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DISEMBARK,V?LEAVE,V?EXIT \?ELS14
	EQUAL?	HERE,CLOSET \?ELS19
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS19:	PRINT	LOOK-AROUND
	RTRUE	
?ELS14:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS23
	PRINTR	"No door."
?ELS23:	EQUAL?	PRSA,V?SMELL \?ELS25
	EQUAL?	HERE,CLOSET \?ELS25
	CALL	PERFORM-PRSA,ODOR
	RTRUE	
?ELS25:	EQUAL?	PRSA,V?SEARCH \?ELS29
	PRINT	NOTHING-NEW
	RTRUE	
?ELS29:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	EQUAL?	HERE,CLOSET \?ELS36
	CALL	V-LOOK
	RSTACK	
?ELS36:	PRINT	ONLY-BLACKNESS
	RTRUE	


	.FUNCT	SHELF-F
	EQUAL?	PRSA,V?PUT,V?PUT-ON \FALSE
	EQUAL?	PRSI,SHELF \FALSE
	IN?	PROTAGONIST,STOOL /FALSE
	CALL	CANT-REACH,SHELF
	RSTACK	


	.FUNCT	BASKET-F
	FSET?	BASKET,UNTEEDBIT /FALSE
	EQUAL?	PRSA,V?EXAMINE \?ELS7
	PRINTR	"The basket is oval-shaped. A handle spans the narrow part."
?ELS7:	EQUAL?	PRSA,V?MEASURE \?ELS9
	PRINTR	"The basket is about fifteen by thirty inches."
?ELS9:	EQUAL?	PRSA,V?CLOSE \?ELS11
	CALL	NO-LID
	RSTACK	
?ELS11:	EQUAL?	PRSA,V?PUT-NEAR,V?PUT \?ELS13
	EQUAL?	PRSI,ORPHANAGE-DOOR \?ELS13
	CALL	PERFORM,V?PUT-ON,BASKET,FRONT-STOOP
	RTRUE	
?ELS13:	CALL	TAKE-BABY-FROM-STOOP,BASKET
	ZERO?	STACK \TRUE
	RFALSE


	.FUNCT	TAKE-BABY-FROM-STOOP,OBJ
	EQUAL?	PRSA,V?TAKE \FALSE
	EQUAL?	PRSO,OBJ \FALSE
	CALL	QUEUED?,I-ORPHANAGE
	ZERO?	STACK /FALSE
	CALL	CCOUNT,PROTAGONIST
	LESS?	STACK,11 \FALSE
	CALL	DEQUEUE,I-ORPHANAGE
	RFALSE	


	.FUNCT	MOTHBALLS-F
	EQUAL?	HERE,CLOSET \FALSE
	PRINT	YOU-CANT-SEE-ANY
	PRINTD	MOTHBALLS
	PRINTR	" here. It must be some imitation mothball air mist."


	.FUNCT	ROOF-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Your view extends to the horizon, which on tiny Phobos usually means a few hundred feet. Thrusting up into sight beyond the horizon are"
	PRINT	PLEASURE-PALACE-DESC
	PRINTD	LGOP
	PRINTI	". On a wide plain between here and the palace, powerful warships are poised for the imminent invasion of Earth.
   Mars dominates the view, a dull red orb spanning a quarter of the sky. Bright blue canals lace the surface, and white caps of ice are visible at both poles.
   A stairway leads down into the building. Near the edge, seemingly painted onto the roof, is"
	CALL	APRINT,HOLE
	PRINTI	". You might be able to jump to the ground, but frankly we advise against it."
	RTRUE	


	.FUNCT	ROOF-OBJECT-F
	EQUAL?	PRSA,V?DISEMBARK,V?LEAP-OFF /?THN6
	EQUAL?	PRSA,V?TAKE-OFF \?ELS5
	EQUAL?	P-PRSA-WORD,W?GET \?ELS5
?THN6:	SET	'PRSO,FALSE-VALUE
	CALL	V-LEAP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS11
	CALL	V-LOOK
	RSTACK	
?ELS11:	EQUAL?	PRSA,V?SEARCH \FALSE
	PRINT	NOTHING-NEW
	RTRUE	


	.FUNCT	I-BLUEPRINT
	CALL	VISIBLE?,SIDEKICK
	ZERO?	STACK /?ELS5
	CALL	LIT?,HERE
	ZERO?	STACK /?ELS5
	LOC	SIDEKICK
	EQUAL?	STACK,SECOND-SLAB,STALLION /?ELS5
	CALL	QUEUED?,I-SIDEKICK-OUT-WINDOW
	ZERO?	STACK \?ELS5
	MOVE	MATCHBOOK,PROTAGONIST
	PRINTI	"   "
	CALL	DPRINT-SIDEKICK
	PRINTI	" trots over to you. ""I've got a plan to bring these Leather Goddess jokers to their knees,"" "
	CALL	HE-SHE
	PRINTI	" says, flipping you a "
	PRINTD	MATCHBOOK
	PRINTI	". "
	CALL	COVER-FILLED-WITH-NOTES
	CALL	SCRAPE-UP-THESE-ITEMS
	RSTACK	
?ELS5:	CALL	QUEUE,I-BLUEPRINT,3
	RFALSE	


	.FUNCT	SCRAPE-UP-THESE-ITEMS
	PRINTI	"""If we can scrape up these items, I can whip up something that'll knock 'em cold! A "
	PRINTD	ANTI-LGOP-MACHINE
	PRINTR	"!!!"""


	.FUNCT	MATCHBOOK-F
	FSET?	MATCHBOOK,UNTEEDBIT /FALSE
	EQUAL?	PRSA,V?KILL \?ELS7
	EQUAL?	P-PRSA-WORD,W?STRIKE \?ELS7
	CALL	PERFORM,V?ON,MATCHBOOK
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?LOOK-INSIDE,V?COUNT,V?OPEN /?THN12
	EQUAL?	PRSA,V?ON \?ELS11
?THN12:	PRINTI	"You briefly open the "
	PRINTD	MATCHBOOK
	PRINTR	" and see that there are no matches left."
?ELS11:	EQUAL?	PRSA,V?CLOSE \?ELS15
	PRINT	ALREADY-IS
	RTRUE	
?ELS15:	EQUAL?	PRSA,V?READ \?ELS17
	PRINTI	"Most of the scrawlings are a ""blueprint"" for a vastly complicated device. Below that is a parts list:
   1."
	CALL	APRINT,BLENDER
	PRINTI	"
   2. six feet of "
	PRINTD	RUBBER-HOSE
	PRINTI	"
   3. a "
	PRINTD	COTTON-BALLS
	PRINTI	"
   4. an "
	PRINTD	EIGHTY-TWO-DEGREE-ANGLE
	PRINTI	"
   5. a "
	PRINTD	HEADLIGHT
	PRINTI	" from any 1933 Ford
   6. a white mouse
   7. any size "
	CALL	DPRINT,PHOTO
	PRINTI	"
   8. a copy of"
	CALL	TPRINT,PHONE-BOOK
	CRLF	
	RTRUE	
?ELS17:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	COVER-FILLED-WITH-NOTES
	CALL	PERFORM,V?OPEN,MATCHBOOK
	RTRUE	


	.FUNCT	COVER-FILLED-WITH-NOTES
	PRINTI	"The cover of the "
	PRINTD	MATCHBOOK
	PRINTI	" is filled with scrawled notations. "
	RTRUE	


	.FUNCT	BOUDOIR-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	MOVE	PROTAGONIST,DIVAN
	CALL	QUEUE,I-BOUDOIR,6
	RSTACK	
?ELS5:	EQUAL?	RARG,M-LOOK \?ELS7
	PRINTI	"There is only enough light here to make out vague shapes. "
	IN?	PROTAGONIST,DIVAN \?CND8
	PRINTI	"You seem to be lying on a plush divan. "
?CND8:	CALL	NOT-ALONE-ON-DIVAN
	FSET?	NOSE,MUNGBIT /TRUE
	PRINTI	" A pleasing odor "
	FSET?	HERE,SMELLEDBIT \?CND14
	PRINTI	"of leather "
?CND14:	PRINTI	"comes from close by."
	RTRUE	
?ELS7:	EQUAL?	RARG,M-SMELL \FALSE
	PRINTI	"Someone nearby is wearing leather. Lots of leather."
	RTRUE	


	.FUNCT	NOT-ALONE-ON-DIVAN
	PRINTI	"You hear heavy breathing from nearby"
	IN?	PROTAGONIST,DIVAN \?CND1
	PRINTI	", and realize that you are not alone on the couch"
?CND1:	PRINTI	"."
	RTRUE	


	.FUNCT	I-BOUDOIR,NOT-CALLED-BY-FUCK=1
	PRINTI	"   You hear a click, and "
	IN?	PROTAGONIST,HERE /?CND1
	PRINTI	"leap to your feet as "
?CND1:	PRINTI	"the room is flooded with light!

"
	PRINTD	HERE
	PRINTI	"
   Oh, no! You have violated the sanctity of a boudoir! And not just any old boudoir, but an"
	PRINT	PRIVATE-BOUDOIR
	PRINTI	"! And not just any old"
	PRINT	PRIVATE-BOUDOIR
	PRINTI	", but an"
	PRINT	PRIVATE-BOUDOIR
	PRINTI	" belonging to "
	PRINTD	LGOP
	PRINTI	"!
   ""The escaped prisoner"
	CALL	VISIBLE?,SIDEKICK
	ZERO?	STACK /?CND4
	PRINTI	"s"
?CND4:	PRINTI	"!"" cries one of "
	PRINTD	LGOP
	PRINTI	". ""Sound the alarm!""
   ""Inform the guards!"" yells another.
   ""Call out the army!""
   ""Alert the space fleet!""
   ""Summon my masseur,"" says the single unfrantic Goddess, calmly pulling a lever. As the floor opens up, you"
	CALL	AND-SIDEKICK
	PRINTI	" plunge down a long chute"
	PRINT	ELLIPSIS
	CALL	INCREMENT-SCORE,9,13
	CALL	GOTO,PLAZA,TRUE-VALUE
	CALL	ULTIMATELY-IN?,SIDEKICK,BOUDOIR
	ZERO?	STACK /?CND7
	MOVE	SIDEKICK,PLAZA
?CND7:	ZERO?	NOT-CALLED-BY-FUCK /TRUE
	EQUAL?	PRSA,V?WAIT /TRUE
	CALL	PLAZA-F,M-END
	RTRUE	


	.FUNCT	LGOP-F
	EQUAL?	LGOP,WINNER \?ELS5
	EQUAL?	PRSA,V?KISS \?ELS10
	EQUAL?	PRSO,ME \?ELS10
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM-PRSA,LGOP
	SET	'WINNER,LGOP
	RTRUE	
?ELS10:	EQUAL?	PRSA,V?TAKE,V?FUCK \?ELS14
	EQUAL?	PRSO,ME \?ELS14
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?FUCK,LGOP
	SET	'WINNER,LGOP
	RTRUE	
?ELS14:	ZERO?	NAUGHTY-LEVEL \?ELS18
	PRINT	LEAVE-ME-ALONE
	RTRUE	
?ELS18:	PRINTI	"""Shut up and kiss me, honey."""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXAMINE \?ELS22
	PRINTI	"The lighting is too dim to see more than vague shapes."
	ZERO?	NAUGHTY-LEVEL /?CND23
	PRINTI	" But very shapely shapes!"
?CND23:	CRLF	
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?KISS,V?FUCK,V?TOUCH \?ELS27
	ZERO?	NAUGHTY-LEVEL \?ELS27
	PRINTI	"You're pushed away. "
	PRINT	LEAVE-ME-ALONE
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?EAT \?ELS31
	ZERO?	NAUGHTY-LEVEL \?ELS36
	CALL	V-FUCK
	RSTACK	
?ELS36:	EQUAL?	NAUGHTY-LEVEL,1 \?ELS38
	PRINT	MISSIONARY-ONLY
	RTRUE	
?ELS38:	PRINTR	"As you dive between her thighs, she arches toward you, shivering with hedonistic pleasure."
?ELS31:	EQUAL?	PRSA,V?TOUCH \?ELS42
	PRINTI	"Your arms discover a soft and eager body. You hear a purr of pleasure"
	EQUAL?	NAUGHTY-LEVEL,2 \?CND43
	CALL	BODIES-PRESS-TOGETHER,STR?414,STR?415
?CND43:	PRINT	PERIOD-CR
	RTRUE	
?ELS42:	EQUAL?	PRSA,V?KISS \?ELS47
	PRINTI	"Your lips meet those of your couchmate -- full, moist lips; the lips of someone who knows how to kiss"
	EQUAL?	NAUGHTY-LEVEL,2 \?CND48
	PRINTI	". A tongue slides teasingly into "
	PRINTD	MOUTH
	CALL	BODIES-PRESS-TOGETHER,STR?416,STR?417
?CND48:	CALL	VISIBLE?,SIDEKICK
	ZERO?	STACK /?CND51
	PRINT	PERIOD-CR
	PRINTI	"   You hear a ""thunk"" as "
	CALL	DPRINT-SIDEKICK
	PRINTI	", humping enthusiastically, falls off "
	CALL	HIS-HER
	PRINTI	" couch"
?CND51:	PRINT	PERIOD-CR
	RTRUE	
?ELS47:	EQUAL?	PRSA,V?SMELL \?ELS55
	CALL	PERFORM-PRSA,ODOR
	RTRUE	
?ELS55:	EQUAL?	PRSA,V?FUCK \FALSE
	PRINTI	"Your couchmate seems only too happy to oblige. You flush with passion"
	EQUAL?	NAUGHTY-LEVEL,2 \?CND58
	CALL	BODIES-PRESS-TOGETHER,STR?418,STR?415
?CND58:	PRINTI	". Suddenly..."
	CRLF	
	CALL	DEQUEUE,I-BOUDOIR
	CALL	I-BOUDOIR,FALSE-VALUE
	RSTACK	


	.FUNCT	BODIES-PRESS-TOGETHER,VERB-STRING,NOUN-STRING
	MOVE	PROTAGONIST,DIVAN
	PRINTI	" as your two bodies draw closer together on the divan"
	ZERO?	MALE \FALSE
	ZERO?	DISCOVERED \FALSE
	SET	'DISCOVERED,TRUE-VALUE
	PRINTI	". You discover, much to your surprise, that you are "
	PRINT	VERB-STRING
	PRINTI	" a woman. Even more surprising, your misgivings are swept away by the heady pleasure of the soft, full "
	PRINT	NOUN-STRING
	PRINTI	" pressing against your own"
	RTRUE	


	.FUNCT	PLAZA-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"This is a wide plaza between"
	PRINT	PLEASURE-PALACE-DESC
	PRINTD	LGOP
	PRINTI	". It is a lovely, bucolic area of gushing fountains, curving flower beds, and lawns of thick, green grass. Birds fly amongst the trees, singing peacefully, as baby squirrels hop across the lawn, lazily collecting nuts."
	RTRUE	
?ELS5:	EQUAL?	RARG,M-SMELL \?ELS7
	PRINTI	"Through the smoke of battle, you see a banana peel squirt from"
	CALL	TPRINT,ANTI-LGOP-MACHINE
	PRINTI	"."
	RTRUE	
?ELS7:	EQUAL?	RARG,M-END \FALSE
	INC	'PLAZA-COUNTER
	PRINTI	"   "
	EQUAL?	PLAZA-COUNTER,1 \?ELS12
	PRINTI	"A half-megaton grenade explodes nearby as the palace guards attempt to repel "
	IN?	SIDEKICK,HERE \?ELS15
	PRINTI	"some"
	JUMP	?CND13
?ELS15:	PRINTI	"an"
?CND13:	PRINTI	" unwanted intruder"
	IN?	SIDEKICK,HERE \?CND18
	PRINTI	"s"
?CND18:	PRINTI	" (namely: you"
	CALL	AND-SIDEKICK
	PRINTI	")."
	CRLF	
	JUMP	?CND10
?ELS12:	EQUAL?	PLAZA-COUNTER,2 \?ELS22
	PRINTI	"The guards now have reinforcements: a row of imposing radium-powered tanks are rolling towards you."
	CRLF	
	JUMP	?CND10
?ELS22:	EQUAL?	PLAZA-COUNTER,3 \?ELS24
	PRINTI	"Giant berserk robotoid sumo wrestlers, each madly waving about three dozen samurai swords, are now storming across the plaza at you."
	CRLF	
	JUMP	?CND10
?ELS24:	EQUAL?	PLAZA-COUNTER,4 \?ELS26
	PRINTI	"With a swooping roar, the"
	PRINT	ATTACK-FLEET
	PRINTI	" of "
	PRINTD	LGOP
	PRINTI	" joins the attack. Several nearby trees are suddenly vaporized."
	CRLF	
	JUMP	?CND10
?ELS26:	EQUAL?	PLAZA-COUNTER,5 \?ELS28
	PRINTI	"The palace guards are setting up a massive dematerialization ray. Closer by, a sumo-robot discovers a boulder in its path, and a large quantity of gravel is created."
	CRLF	
	JUMP	?CND10
?ELS28:	EQUAL?	PLAZA-COUNTER,6 \?ELS30
	PRINTI	"A Phobosian Chomper is faster than a cheetah, meaner than a Tyrannosaurus Rex, bigger than a sperm whale, and as hungry as the state of Texas. We mention this because fifty of them just entered the plaza and spotted you."
	CRLF	
	JUMP	?CND10
?ELS30:	EQUAL?	PLAZA-COUNTER,7 \?ELS32
	PRINTI	"Several fifty-foot craters appear as the"
	PRINT	ATTACK-FLEET
	PRINTI	" begins lobbing ion bombs. As they veer around for a more precise attack, the tanks close in, and you realize that each one is larger than the Upper Sandusky City Hall."
	CRLF	
	JUMP	?CND10
?ELS32:	EQUAL?	PLAZA-COUNTER,8 \?ELS34
	PRINTI	"A couple of buildings behind you silently vanish, indicating that the palace guards are better at assembling a death ray than at aiming it. However, in sixty centuries of repelling intruders, they've never missed twice. Meanwhile, one of the Chompers has stopped to swallow a herd of goats that was grazing nearby, thus slowing it down for a full tenth of a second."
	CRLF	
	JUMP	?CND10
?ELS34:	EQUAL?	PLAZA-COUNTER,9 \?ELS36
	PRINTI	"The guards have finished aiming the death ray, and have begun the activation sequence. The ground quakes as the berserko robotoids plow through the rubble toward you; the wind from their whirling swords knocks over a few trees. The tanks loom above you, their gun turrets blocking out the sun. Beyond them, the"
	PRINT	ATTACK-FLEET
	PRINTI	" is sweeping in for a final attack."
	CRLF	
	JUMP	?CND10
?ELS36:	EQUAL?	PLAZA-COUNTER,10 \?CND10
	CALL	JIGS-UP,STR?420
?CND10:	CALL	VISIBLE?,SIDEKICK
	ZERO?	STACK /TRUE
	PRINTI	"   "
	CALL	DPRINT-SIDEKICK
	EQUAL?	PLAZA-COUNTER,1 \?ELS44
	MOVE	ANTI-LGOP-MACHINE,HERE
	PRINTI	" shouts, ""Okay, this is it!"
	FIRST?	SIDEKICK \?ELS47
	CALL	ROB,SIDEKICK,PROTAGONIST
	PRINTI	""" "
	CALL	HE-SHE,TRUE-VALUE
	PRINTI	" hands you everything "
	CALL	HE-SHE
	PRINTI	"'s carrying. """
	JUMP	?CND45
?ELS47:	PRINTI	" "
?CND45:	PRINTI	"Gotta start building that "
	PRINTD	ANTI-LGOP-MACHINE
	PRINTI	"! "
	JUMP	?CND42
?ELS44:	PRINTI	", hammering and twiddling madly at the growing machine, yells, """
	ZERO?	RIGHT-PART /?ELS54
	PRINTI	"Okay, things are going "
	SUB	PLAZA-COUNTER,2
	GET	HYPE-WORD,STACK
	PRINT	STACK
	PRINTI	"! "
	JUMP	?CND52
?ELS54:	SUB	PLAZA-COUNTER,2
	GET	PARTS-LIST,STACK >MISSING-PART
	PRINTI	"Well, I'll try and work around the missing "
	EQUAL?	MISSING-PART,PHOTO \?ELS60
	GETP	PHOTO,P?SDESC
	PRINT	STACK
	JUMP	?CND58
?ELS60:	PRINTD	MISSING-PART
?CND58:	PRINTI	". "
?CND52:	EQUAL?	PLAZA-COUNTER,9 \?CND42
	PRINTI	"There! I think it's all done. Cross your fingers, kiddo!"" "
	CALL	HE-SHE,TRUE-VALUE
	PRINTI	" switches on the device. Amidst showers of sparks, a powerful electric arc bridges two electrodes. The machine shudders, and "
	ZERO?	MISSING-PART /?ELS68
	PRINTI	"awe-inspiring rays of raw plasma begin shooting in every direction. You and "
	CALL	DPRINT-SIDEKICK
	PRINTI	" dive to the ground. Crashing spaceships collide with careening robotoid monsters; the tanks, inches before pancaking you, become pools of molten metal. A stray plasma ray strikes the only remaining tree in the plaza, and you are fatally wounded as a coconut drops onto "
	PRINTD	HEAD
	PRINTI	". The last sound you hear is "
	CALL	DPRINT-SIDEKICK
	PRINTI	"'s voice, saying,"
	CALL	EXPLETIVE
	PRINTI	"I was going to use that "
	EQUAL?	MISSING-PART,PHOTO \?ELS72
	GETP	PHOTO,P?SDESC
	PRINT	STACK
	JUMP	?CND70
?ELS72:	PRINTD	MISSING-PART
?CND70:	PRINTI	" to build a coconut deflector."""
	CRLF	
	JUMP	?CND66
?ELS68:	PRINTI	"you "
	FSET?	NOSE,MUNGBIT \?ELS79
	PRINTI	"see"
	JUMP	?CND77
?ELS79:	PRINTI	"smell"
?CND77:	PRINTI	" something yellow shoot from the machine."
	FSET?	NOSE,MUNGBIT \?ELS84
	PRINTI	" It's a banana peel!"
	CRLF	
	JUMP	?CND82
?ELS84:	CRLF	
	CALL	PERFORM,V?SMELL,ODOR
?CND82:	PRINTI	"   The peel lands a few feet away, as the "
	PRINTD	ANTI-LGOP-MACHINE
	PRINTI	" gives one final shudder and self-destructs in an orgy of flames and shrapnel!
   The attacking forces continue to close, and certain death is only seconds away when one of the Chompers, loping toward you at nearly Mach One, steps on the banana peel, and slips a few inches to one side before righting itself. This is enough, however, to nudge a tank into a crater, tripping one of the samurai robots!
   More and more of the attacking forces plow into the mess in the crater, like some improbably fantastical football tackle. A stray grenade lands right in its midst, and the resulting plume of debris shears the fins off the leading warship. Your heart leaps as the entire"
	PRINT	ATTACK-FLEET
	PRINTI	" of "
	PRINTD	LGOP
	PRINTI	" plummets toward the ground. The mass of flaming metal strikes the ground, and a tremendous explosion knocks you senseless!

   Eventually, daylight intrudes upon your senselessness and illuminates a sleepy-looking gas station. You are lying at the edge of a dusty road, once again wearing your comfortable old overalls. Though dirty, dishevelled, and bleeding from a few superficial cuts, you are nevertheless aglow in the knowledge that Earth is safe from the threat of "
	PRINTD	LGOP
	PRINTI	".
   As "
	PRINTD	HEAD
	PRINTI	" clears, three uniformed "
	ZERO?	MALE /?ELS89
	PRINTI	"girls come bounc"
	JUMP	?CND87
?ELS89:	PRINTI	"guys come pound"
?CND87:	PRINTI	"ing out of the service station toward you. ""Oh, my goodness,"" they "
	ZERO?	MALE /?ELS95
	PRINTI	"coo"
	JUMP	?CND93
?ELS95:	PRINTI	"call out"
?CND93:	PRINTI	", in perfect unison. ""Are you all right?""

   Coming soon from Infocom: GAS PUMP GIRLS MEET THE PULSATING INCONVENIENCE FROM PLANET X."
	CRLF	
	SET	'RANK,9
	SET	'EXT-MAX,INT-MAX
?CND66:	CALL	FINISH
?CND42:	PRINTI	"Hand me a"
	CALL	PRINT-PART
	PRINTI	"."""
	CRLF	
	SET	'RIGHT-PART,FALSE-VALUE
	CALL	THIS-IS-IT,SIDEKICK
	RSTACK	


	.FUNCT	PRINT-PART,NEXT-PART
	SUB	PLAZA-COUNTER,1
	GET	PARTS-LIST,STACK >NEXT-PART
	CALL	THIS-IS-IT,NEXT-PART
	EQUAL?	NEXT-PART,EIGHTY-TWO-DEGREE-ANGLE \?ELS3
	PRINTI	"n "
	JUMP	?CND1
?ELS3:	PRINTI	" "
?CND1:	EQUAL?	NEXT-PART,PHOTO \?ELS10
	GETP	PHOTO,P?SDESC
	PRINT	STACK
	RTRUE	
?ELS10:	PRINTD	NEXT-PART
	RTRUE	


	.FUNCT	GENERIC-MACHINE-F,NUM
	CALL	CANAL-LOC >NUM
	EQUAL?	HERE,CANAL \?ELS5
	GRTR?	NUM,31 /?THN8
	LESS?	NUM,13 \?ELS5
?THN8:	RETURN	ODD-MACHINE
?ELS5:	EQUAL?	PRSA,V?ASK-ABOUT \?ELS11
	CALL	VISIBLE?,ODD-MACHINE
	ZERO?	STACK /?ELS16
	RETURN	ODD-MACHINE
?ELS16:	RETURN	ANTI-LGOP-MACHINE
?ELS11:	EQUAL?	SIDEKICK,WINNER \FALSE
	CALL	QUEUED?,I-BLUEPRINT
	ZERO?	STACK \FALSE
	RETURN	ANTI-LGOP-MACHINE

	.ENDI
