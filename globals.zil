"GLOBALS for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first 8 without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<ADJ-SYNONYM LARGE LARGER HUGE HUGER BIG BIGGER GIANT GIGANTIC TREMENDOUS
	     MIGHTY MIGHTIER MASSIVE>

<ADJ-SYNONYM WIDE BROAD>

<ADJ-SYNONYM SMALL SMALLER TINY TINIER LITTLE PETITE TEENSY WEENSY>

<ADJ-SYNONYM MY MINE>

<GLOBAL LIT T>

<GLOBAL RANK 0>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL HERE <>>

<GLOBAL INT-MAX 429> ;"sum of highest possible scores"

<GLOBAL EXT-MAX 9309> ;"what you tell player the maximum score is"

<ROUTINE INCREMENT-SCORE (BASE VAR "OPTIONAL" (INC-RANK <>) "AUX" CHANGE DIF)
	 <COND (.INC-RANK
		<SETG RANK <+ ,RANK 1>>)>
	 <SET CHANGE <+ <RANDOM .VAR> .BASE>>
	 <SET DIF <- <+ .BASE .VAR> .CHANGE>>
	 <SETG INT-MAX <- ,INT-MAX .DIF>>
	 <SETG EXT-MAX <+ ,INT-MAX <RANDOM <- ,EXT-MAX ,INT-MAX>>>>
	 <SETG SCORE <+ ,SCORE .CHANGE>>>

<OBJECT GLOBAL-OBJECTS
	(SYNONYM ZZMGCK) ;"No, this synonym doesn't need to exist... sigh"
	(DESC "it")
	(FLAGS INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT SEARCHBIT
	       TRANSBIT WEARBIT MUNGBIT ONBIT LIGHTBIT RLANDBIT WORNBIT
	       VEHBIT INDOORSBIT CONTBIT VOWELBIT LOCKEDBIT NDESCBIT DOORBIT
	       ACTORBIT SMELLEDBIT UNTEEDBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM ZZMGCK) ;"Yes, this synonym needs to exist... sigh"
	;(DESCFCN 0)
        ;(GLOBAL GLOBAL-OBJECTS)
	;(FDESC "F")
	;(LDESC "F")
	;(SIZE 0)
	;(TEXT "")
	;(CAPACITY 0)
	;(THINGS <PSEUDO (ZZMGCK ZZMGCK ME-F)>)>

<OBJECT ROOMS
	(IN TO ROOMS)
	(DESC "it")>

<OBJECT INTDIR
	(IN GLOBAL-OBJECTS)
	(DESC "direction")
	(SYNONYM DIRECT)
	(ADJECTIVE NORTH SOUTH EAST WEST NW NE SW SE)
	(ACTION INTDIR-F)>

<ROUTINE INTDIR-F ()
	 <COND (<AND <VERB? BOARD>
		     <EQUAL? ,P-PRSA-WORD ,W?RIDE>>
		<COND (<IN? ,PROTAGONIST ,STALLION>
		       <DO-WALK ,P-DIRECTION>)
		      (<IN? ,STALLION ,HERE>
		       <DO-FIRST "mount">)
		      (T
		       <TELL ,THERES-NOTHING "to ride!" CR>)>)>>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(DESC "number")
	(SYNONYM NUMBER)
	(ADJECTIVE WIFE HUSBAND \#) ;"for things like WIFE # 375"
	(ACTION INTNUM-F)>

<ROUTINE INTNUM-F ()
	 <COND (<AND <ADJ-USED ,A?WIFE>
		     <OR <NOT <EQUAL? ,HERE ,INNER-HAREM>>
			 <NOT ,MALE>>
		     <NOT <PICKING-WIFE>>>
		<SETG P-WON <>>
		<TELL ,YOU-CANT-SEE-ANY "wife here!" CR>)
	       (<AND <ADJ-USED ,A?HUSBAND>
		     <OR <NOT <EQUAL? ,HERE ,INNER-HAREM>>
			 ,MALE>
		     <NOT <PICKING-WIFE>>>
		<SETG P-WON <>>
		<TELL ,YOU-CANT-SEE-ANY "husband here!" CR>)
	       (<VERB? ANSWER-KLUDGE>
		<PERFORM ,V?USE-QUOTES ,INTNUM>
		<RTRUE>)
	       (<AND <EQUAL? ,P-NUMBER ,CHOICE-NUMBER>
		     <IN? ,SULTANS-WIFE ,HERE>>
		<COND (<PRSO? ,INTNUM>
		       <PERFORM-PRSA ,SULTANS-WIFE ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,SULTANS-WIFE>
		       <RTRUE>)>)
	       (<OR <AND <VERB? ASK-NO-ONE-FOR PICK>
			 <IN? ,HAREM-GUARD ,HERE>>
		    <AND <VERB? ASK-FOR>
			 <PRSO? ,HAREM-GUARD>>>
		<PICK-WIFE ,INTNUM>)
	       (<AND <EQUAL? ,HERE ,VIZICOMM-BOOTH>
		     <VERB? SET>>
		<PERFORM-PRSA ,VIZICOMM>
		<RTRUE>)>>

<ROUTINE PICKING-WIFE ()
	 <COND (<AND <VERB? ASK-NO-ONE-FOR PICK>
		     <IN? ,HAREM-GUARD ,HERE>>
		<RTRUE>)
	       (<AND <VERB? ASK-FOR>
		     <PRSO? ,HAREM-GUARD>>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")	;"DESC must be 6 characters long! --pdl 3/4/86"
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT TOUCHBIT)>

<OBJECT HIM
	(IN GLOBAL-OBJECTS)
	(SYNONYM HIM HIMSELF)
	(DESC "him")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT HER
	(IN GLOBAL-OBJECTS)
	(SYNONYM HER HERSELF)
	(DESC "her")
	(FLAGS NARTICLEBIT TOUCHBIT)>

<OBJECT EACH-OTHER
	(IN GLOBAL-OBJECTS)
	(DESC "it")
	(SYNONYM OTHER ITSELF)
	(ADJECTIVE EACH)
	(ACTION EACH-OTHER-F)>

<ROUTINE EACH-OTHER-F ()
	 <COND (<PRSI? ,EACH-OTHER>
		<PERFORM-PRSA ,PRSO ,PRSO>
		<RTRUE>)
	       (<NOT <NOUN-USED ,W?ITSELF ,EACH-OTHER>>
		<SETG P-WON <>>
		<COND (<ADJ-USED ,A?EACH>
		       <CANT-USE ,A?EACH T>)
		      (T
		       <CANT-USE ,W?OTHER T>)>
		<RTRUE>)>>

<OBJECT MAN-WOMAN
	(IN GLOBAL-OBJECTS)
	(SDESC "")
	(SYNONYM MAN WOMAN)
	(ACTION MAN-WOMAN-F)>

<ROUTINE MAN-WOMAN-F ("AUX" PERSON)
	 <COND (<VERB? FOLLOW> ;"for YOUNG WOMAN"
		<COND (<EQUAL? ,FOLLOW-FLAG 4>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 5>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,FOLLOW-FLAG 6>
		       <DO-WALK ,P?EAST>)
		      (T
		       <V-WALK-AROUND>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?MAN> ;"MAN is the PRSO"
		     <PRSO? ,MAN-WOMAN> ;"in case PRSI is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA .PERSON ,PRSI>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 0> ,W?WOMAN> ;"WOMAN is the PRSO"
		     <PRSO? ,MAN-WOMAN> ;"in case PRSI is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-WOMAN>>
		       <PERFORM-PRSA .PERSON ,PRSI>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 1> ,W?MAN> ;"MAN is the PRSI"
		     <PRSI? ,MAN-WOMAN> ;"in case PRSO is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-MAN>>
		       <PERFORM-PRSA ,PRSO .PERSON>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)
	       (<AND <EQUAL? <GET ,P-NAMW 1> ,W?WOMAN> ;"WOMAN is the PRSI"
		     <PRSI? ,MAN-WOMAN> ;"in case PRSO is also MAN or WOMAN">
		<COND (<SET PERSON <FIND-WOMAN>>
		       <PERFORM-PRSA ,PRSO .PERSON>
		       <RTRUE>)
		      (T
		       <CANT-SEE ,MAN-WOMAN>)>)>>

<ROUTINE FIND-MAN ()
	 <PUTP ,MAN-WOMAN ,P?SDESC "man">
	 <COND (<IN? ,SALESMAN ,HERE>
		<RETURN ,SALESMAN>)
	       (<IN? ,MAD-SCIENTIST ,HERE>
		<RETURN ,MAD-SCIENTIST>)
	       (<IN? ,MITRE ,HERE>
		<RETURN ,MITRE>)
	       (<IN? ,PROPRIETOR ,HERE>
		<RETURN ,PROPRIETOR>)
	       (<AND <IN? ,THORBAST ,HERE>
		     ,MALE>
		<RETURN ,THORBAST>)
	       (<AND <IN? ,YOUNG-WOMAN ,HERE>
		     <NOT ,MALE>>
		<RETURN ,YOUNG-WOMAN>)
	       (<AND <IN? ,SULTAN ,HERE>
		     ,MALE>
		<RETURN ,SULTAN>)
	       (<AND <IN? ,SULTANS-WIFE ,HERE>
		     <NOT ,MALE>>
		<RETURN ,SULTANS-WIFE>)
	       (<AND <VISIBLE? ,SIDEKICK>
		     ,MALE>
		<RETURN ,SIDEKICK>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-WOMAN ()
	 <PUTP ,MAN-WOMAN ,P?SDESC "woman">
	 <COND (<AND <IN? ,THORBAST ,HERE>
		     <NOT ,MALE>>
		<RETURN ,THORBAST>)
	       (<AND <IN? ,YOUNG-WOMAN ,HERE>
		     ,MALE>
		<RETURN ,YOUNG-WOMAN>)
	       (<AND <IN? ,THETA ,HERE>
		     <NOT <FSET? ,THETA ,MUNGBIT>>>
		<RETURN ,THETA>)
	       (<IN? ,LGOP ,HERE>
		<RETURN ,LGOP>)
	       (<AND <IN? ,SULTAN ,HERE>
		     <NOT ,MALE>>
		<RETURN ,SULTAN>)
	       (<AND <IN? ,SULTANS-WIFE ,HERE>
		     ,MALE>
		<RETURN ,SULTANS-WIFE>)
	       (<AND <VISIBLE? ,SIDEKICK>
		     <NOT ,MALE>>
		<RETURN ,SIDEKICK>)
	       (T
		<RFALSE>)>>

<OBJECT NOT-HERE-OBJECT
	(DESC "it")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 <COND (<AND <PRSO? ,NOT-HERE-OBJECT>
		     <PRSI? ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<AND <EQUAL? ,P-XNAM ,W?BODY>
		     <EQUAL? ,P-XADJN ,W?MY <>>>
		<COND (<PRSO? ,NOT-HERE-OBJECT>
		       <SETG PRSO ,ME>)
		      (T
		       <SETG PRSI ,ME>)>
		<RFALSE>)
	       (<AND <EQUAL? ,P-XNAM ,W?HAND ,W?HANDS>
		     <EQUAL? ,P-XADJN ,W?MITRE ,W?KING\'S>
		     <VERB? SHAKE TAKE>>
		<PERFORM ,V?SHAKE-WITH ,HANDS ,MITRE>
		<RTRUE>)
	       (<AND <OR <EQUAL? ,P-XNAM ,W?HANDS ,W?HAND ,W?PALM>
			 <EQUAL? ,P-XNAM ,W?FINGER ,W?EYE ,W?EYES>
			 <EQUAL? ,P-XNAM ,W?HEAD ,W?EARS ,W?EAR>
			 <EQUAL? ,P-XNAM ,W?LIP ,W?LIPS ,W?MOUTH>
			 <EQUAL? ,P-XNAM ,W?KNEECAP ,W?KNEE ,W?KNEES>
			 <EQUAL? ,P-XNAM ,W?NOSE ,W?NOSTRIL ,W?BALLS>
			 <EQUAL? ,P-XNAM ,W?PENIS ,W?COCK ,W?ASS>
			 <EQUAL? ,P-XNAM ,W?TITS ,W?BREAST ,W?BOSOM>
			 <EQUAL? ,P-XNAM ,W?CUNT ,W?VAGINA ,W?PUSSY>
			 <EQUAL? ,P-XNAM ,W?TIT ,W?BODY>>
		     <OR <EQUAL? ,P-XADJN ,W?TRENT ,W?TIFFAN ,W?TIFF\'S>
			 <EQUAL? ,P-XADJN ,W?GODDESSES ,W?SHAPE ,W?COUCHMATE>
			 <EQUAL? ,P-XADJN ,W?THORBAST ,W?ASSASSIN ,W?SALESMAN>
			 <EQUAL? ,P-XADJN ,W?SCIENTIST ,W?GORILLA ,W?MONKEY>
			 <EQUAL? ,P-XADJN ,W?KING\'S ,W?MITRE ,W?SULTAN>
			 <EQUAL? ,P-XADJN ,W?PROPRIETOR ,W?OWNER ,W?GUARD>
			 <EQUAL? ,P-XADJN ,W?PRINCE ,W?DAUGHTER ,W?THETA>
			 <EQUAL? ,P-XADJN ,W?BARTENDER ,W?WIFE\'S ,W?HUSBAND>
			 <EQUAL? ,P-XADJN ,W?ELYSIA ,W?ELYSIUM ,W?WOMAN>
			 <EQUAL? ,P-XADJN ,W?ROBOT ,W?BABY\'S>
			 <EQUAL? ,P-XADJN ,W?MAN\'S ,W?HIS ,W?HER>>>
		<TELL
"[Sorry. Given limited space, we can't handle everything. Therefore, you can
only refer to characters in the story, not individual body parts. For example,
you can KISS IRWIN but you can't KISS IRWIN'S ELBOW.]" CR>
		<RTRUE>)
	       (<PRSO? ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (<AND .PRSO?
		     <PRSO-MOBY-VERB?>>
		<SET X T>)
	       (<AND <NOT .PRSO?>
		     <PRSI-MOBY-VERB?>>
		<SET X T>)>
	 <COND (.X ;"the verb is a moby-find verb"
		<COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
		       <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
			      <RTRUE>)>)
		      (T
		       <RFALSE>)>
		<COND (<VERB? WALK-TO FOLLOW>
		       <V-WALK-AROUND>)
		      (T
		       <TELL "[" ,YOULL-HAVE-TO "be more specific.]" CR>)>)
	       (T
		<COND (<EQUAL? ,WINNER ,PROTAGONIST>
		       <TELL "You">)
		      (T
		       <TELL "Looking confused," T ,WINNER " says, \"I">)>
		<TELL " can't ">
		<COND (<EQUAL? ,P-XNAM ,W?ODOR ,W?SMELL ,W?SCENT>
		       <TELL "smell">)
		      (T
		       <TELL "see">)>
		<COND (<OR <NOT <NAME? ,P-XNAM>>
			   <EQUAL? ,P-XNAM ,W?FORD>>
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!">
		<COND (<NOT <EQUAL? ,WINNER ,PROTAGONIST>>
		       <TELL "\"">)>
		<CRLF>)>
	 <STOP>>

<ROUTINE PRSO-MOBY-VERB? ()
	 <COND (<OR <EQUAL? ,PRSA ,V?WHAT ,V?WHERE>
		    <EQUAL? ,PRSA ,V?WAIT-FOR ,V?WALK-TO ,V?MAKE>
		    <EQUAL? ,PRSA ,V?BUY ,V?CALL ,V?SAY>
		    <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?PHONE>
		    <EQUAL? ,PRSA ,V?USE-QUOTES ,V?ANSWER-KLUDGE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE PRSI-MOBY-VERB? ()
	 <COND (<EQUAL? ,PRSA ,V?ASK-ABOUT ,V?ASK-FOR ,V?TELL-ABOUT>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
;"Protocol: return T if case was handled and msg TELLed, NOT-HERE-OBJECT
  if 'can't see' msg TELLed, <> if PRSO/PRSI ready to use"
;"Special-case code goes here. <MOBY-FIND .TBL> returns # of matches. If 1,
then P-MOBY-FOUND is it. You can treat the 0 and >1 cases alike or differently.
Always return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	<COND (<EQUAL? 1 .M-F>
	       ;<COND (,DEBUG
		      <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<AND <L? 1 .M-F>
		    <SET OBJ <APPLY <GETP <SET OBJ <GET .TBL 1>> ,P?GENERIC>>>>
;"Protocol: returns .OBJ if that's the one to use
  		    ,NOT-HERE-OBJECT if case was handled and msg TELLed
		    <> if WHICH-PRINT should be called"
	       ;<COND (,DEBUG
		      <TELL "[Generic: " D .OBJ "]" CR>)>
	       <COND (<EQUAL? .OBJ ,NOT-HERE-OBJECT>
		      <RTRUE>)
		     (.PRSO?
		      <SETG PRSO .OBJ>
		      <THIS-IS-IT ,PRSO>)
		     (T
		      <SETG PRSI .OBJ>)>
	       <RFALSE>)
	      (T
	       ,NOT-HERE-OBJECT)>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (,P-OFLAG
	        <COND (,P-XADJ
		       <TELL " ">
		       <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM
		       <TELL " ">
		       <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT LOVE ;"for MAKE LOVE TO someone"
	(IN GLOBAL-OBJECTS)
	(DESC "love")
	(SYNONYM LOVE)
	(FLAGS NARTICLEBIT)
	(ACTION LOVE-F)>

<ROUTINE LOVE-F ("AUX" LOVER)
	 <COND (<VERB? MAKE>
		<COND (<SET LOVER <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?FUCK .LOVER>
		       <RTRUE>)
		      (T
		       <TELL "Alone? How odd." CR>)>)>>

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP SNOOZE)
	(FLAGS NARTICLEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       (<AND <VERB? PUT-TO>
		     <PRSI? ,GLOBAL-SLEEP>>
		<TELL "You're not a hypnotist." CR>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND)
	(SDESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<EQUAL? ,HERE ,IN-SPACE>
		<CANT-SEE ,GROUND>
		<RTRUE>)
	       (<OR <FSET? ,HERE ,INDOORSBIT>
		    <EQUAL? <LOC ,PROTAGONIST> ,BARGE>>
		<PUTP ,GROUND ,P?SDESC "floor">)
	       (T
		<PUTP ,GROUND ,P?SDESC "ground">)>
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,SPAWNING-GROUND>
		       <TELL ,OOZY-WITH-SLIME CR>)
		      (<AND <GLOBAL-IN? ,HOLE ,HERE>
			    <NOT <HOLE-INVISIBLE>>>
		       <TELL "You notice" AR ,HOLE>)
		      (<EQUAL? ,HERE ,CELL>
		       <TELL "Soft. Cushiony." CR>)
		      (<EQUAL? ,HERE ,OTHER-CELL>
		       <TELL "Rock-hard." CR>)
		      (<AND <EQUAL? ,HERE ,HOLD>
		     	    <EQUAL? ,SIDEKICK-EXPLODED 1>>
		       <SPLATTERED-DESC>
		       <CRLF>)
		      (<IN-CATACOMBS>
		       <TELL ,CATACOMBS-WATER-DESC CR>)>)
	       (<AND <VERB? TOUCH>
		     <EQUAL? ,HERE ,CELL ,OTHER-CELL>>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (<VERB? CLIMB-UP CLIMB-ON CLIMB BOARD>
		<WASTES>)
	       (<VERB? LOOK-UNDER>
		<IMPOSSIBLES>)
	       (<VERB? LEAVE>
		<DO-WALK ,P?UP>)
	       (<AND <VERB? LEAP STAND-ON>
		     <EQUAL? ,HERE ,ROOF>>
		<PERFORM ,V?LEAP ,ROOMS> ;"V-LEAP handles it"
		<RTRUE>)>>

;<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>

;<ROUTINE WALLS-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,HOLD>
		     <EQUAL? ,SIDEKICK-EXPLODED 1>>
		<SPLATTERED-DESC>
		<CRLF>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF)
	(ADJECTIVE TOWERING)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<AND <EQUAL? ,HERE ,HOLD>
		       	    <EQUAL? ,SIDEKICK-EXPLODED 1>>
		       <SPLATTERED-DESC>
		       <CRLF>)
		      (<AND <EQUAL? ,HERE ,CELL>
		     	    ,HOLE-OPEN>
		       <TELL "There's a hole in the ceiling." CR>)
		      (<AND <EQUAL? ,HERE ,BEDROOM>
			    <FSET? ,BEDROOM ,MUNGBIT>>
		       <TELL "Most of the ceiling is now gone." CR>)>)
	       (<NOT <FSET? ,HERE ,INDOORSBIT>>
		<CANT-SEE ,CEILING>)
	       (<AND <VERB? ENTER>
		     <EQUAL? ,HERE ,CELL>
		     ,HOLE-OPEN>
		<DO-WALK ,P?UP>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT ODOR
	(IN LOCAL-GLOBALS)
	(DESC "odor")
	(SYNONYM SMELL ODOR SCENT AROMA)
	(ADJECTIVE STRONG FAMILIAR FOUL HEADY PLEASANT)
	(FLAGS VOWELBIT)
	(ACTION ODOR-F)>

<ROUTINE ODOR-F ()
	 <COND (<AND <EQUAL? ,HERE ,IN-SPACE>
		     <NOT <IN? ,THORBAST ,HERE>>>
	        <TELL ,CANT-SMELL>)
	       (<AND <EQUAL? ,HERE ,MENS-ROOM ,LADIES-ROOM>
		     <RUNNING? ,I-URGE>>
		<TELL ,CANT-SMELL>)
	       (<AND <EQUAL? ,HERE ,PLAZA>
		     <L? ,PLAZA-COUNTER 9>>
		<TELL ,CANT-SMELL> ;"the Plaza odor comes after final prompt")
	       (<OR <VERB? SMELL>
		    <AND <VERB? EXAMINE>
			 <EQUAL? ,P-PRSA-WORD ,W?DESCRIBE>>>
		<COND (<GETP ,HERE ,P?ODOR>
		       <COND (<FSET? ,HERE ,SMELLEDBIT>
			      <TELL
"There is a strong odor of " <GETP ,HERE ,P?ODOR> " in the air." CR>)
			     (T
			      <FSET ,HERE ,SMELLEDBIT>
			      <SCRATCH-N-SNIFF>
			      <APPLY <GETP ,HERE ,P?ACTION> ,M-SMELL>
			      <CRLF>)>)
		      (<EQUAL? ,HERE ,INNER-HAREM>
		       <SETG HERE ,HAREM>
		       <PERFORM ,V?SMELL ,ODOR>
		       <SETG HERE ,INNER-HAREM>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,GARDEN>
		       <NO-SCRATCH-N-SNIFF "fresh honeysuckle">)
		      (<AND <ACCESSIBLE? ,CHOCOLATE>
			    <NOT <FSET? ,CHOCOLATE ,UNTEEDBIT>>>
		       <TELL "[the " D ,CHOCOLATE "]" CR>
		       <PERFORM ,V?SMELL ,CHOCOLATE>
		       <RTRUE>)
		      (T
		       <TELL ,CANT-SMELL>)>)>>

<ROUTINE SCRATCH-N-SNIFF ("OPTIONAL" (NUM <>))
	 <TELL "[Scratch 'n' sniff spot number ">
	 <COND (.NUM
		<PRINTN .NUM>)
	       (T
		<PRINTN <GETP ,HERE ,P?ODOR-NUMBER>>)>
	 <TELL ,HIT-RETURN "continue.]">
	 <READ ,P-INBUF ,P-LEXV>
	 <CRLF>>

<ROUTINE NO-SCRATCH-N-SNIFF (STRING)
	 <TELL
"[Too bad there's no scratch 'n' sniff for this one, huh?]|
|
Ahhh, the odor of " .STRING "!" CR>>

<OBJECT WATER
	(IN LOCAL-GLOBALS)
	(DESC "water")
	(SYNONYM WATER FOUNTAIN POOL OASIS)
	(ADJECTIVE FRESH CANAL DARK BRACKISH STAGNANT WARM LARGE REFLECTING)
	(FLAGS NARTICLEBIT)
	(ACTION WATER-F)>

<ROUTINE WATER-F ()
	 <COND (<AND <EQUAL? ,HERE ,MINARET ,DUNETOP>
		     <TOUCHING? ,WATER>>
		<CANT-REACH ,WATER>)
	       (<VERB? DRINK BUY>
		<TELL "You're not thirsty." CR>)
	       (<VERB? LOOK-INSIDE LOOK-UNDER EXAMINE>
		<TELL "The water is dark and murky." CR>)
	       (<VERB? PASS MAKE>
		<V-PEE>)
	       (<VERB? REACH-IN>
		<TELL "Your hand is now wet." CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,WATER>>
		<PERFORM ,V?PUT ,PRSO ,WATER>
		<RTRUE>)
	       (<GLOBAL-IN? ,CANAL-OBJECT ,HERE>
		<COND (<PRSO? ,WATER>
		       <PERFORM-PRSA ,CANAL-OBJECT ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,CANAL-OBJECT>
		       <RTRUE>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WATER>>
		<COND (<AND <PRSO? ,RAFT>
			    <EQUAL? ,HERE ,OASIS>>
		       <TELL "Next you'll be putting yachts in bathtubs!" CR>)
		      (<AND <PRSO? ,RAFT>
			    <IN-CATACOMBS>>
		       <PERFORM ,V?DROP ,RAFT>
		       <RTRUE>)
		      (T
		       <WASTES>)>)
	       (<AND <VERB? ON WALK> ;"for TURN ON WATER or RUN WATER"
		     <EQUAL? ,HERE ,MENS-ROOM ,LADIES-ROOM>>
		<PERFORM ,V?FLUSH ,TOILET>
		<RTRUE>)
	       (<VERB? BOARD ENTER CRAWL-UNDER>
		<V-SWIM>)>>

;<OBJECT SKY
	(IN GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY)
	(ACTION SKY-F)>

;<ROUTINE SKY-F ()
	 <COND (<FSET? ,HERE ,INDOORSBIT>
		<CANT-SEE ,SKY>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS HAND PALM FINGER)
	(ADJECTIVE BARE MY YOUR)
	(DESC "your hand")
	(FLAGS NDESCBIT TOUCHBIT NARTICLEBIT PARTBIT)
	(ACTION HANDS-F)>

<ROUTINE HANDS-F ("AUX" ACTOR)
	 <COND (<VERB? APPLAUD>
		<SETG PRSO <>>
		<V-APPLAUD>)  
	       (<VERB? SHAKE>
		<COND (<EQUAL? ,HERE ,THRONE-ROOM>
		       <PERFORM ,V?SHAKE-WITH ,HANDS ,MITRE>
		       <RTRUE>)
		      (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "with">>
		       <PERFORM ,V?SHAKE-WITH ,HANDS .ACTOR>
		       <RTRUE>)
		      (T
		       <TELL "Pleased to meet you." CR>)>)
	       (<VERB? COUNT>
		<COND (<NOUN-USED ,W?FINGER ,HANDS>
		       <TELL "Ten">)
		      (T
		       <TELL "Two">)>
		<TELL ", as usual." CR>)
	       (<VERB? CLEAN>
		<TELL "Done." CR>)
	       (<AND <VERB? TAKE-WITH>
		     <PRSI? ,HANDS>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,EYES>>
		<PERFORM ,V?SPUT-ON ,EYES ,HANDS>
		<RTRUE>)
	       (<AND <VERB? PUT-ON PUT>
		     <PRSI? ,EARS>>
		<PERFORM ,V?SPUT-ON ,EARS ,HANDS>
		<RTRUE>)
	       (<AND <VERB? SPUT-ON>
		     <PRSO? ,EYES ,EARS, NOSE>>
		<COND (,GONE-APE
		       <TELL ,DEXTERITY>)
		      (<G? <ITEMS-CARRIED> 0>
		       <TELL ,YOU-CANT "do that with " 'HANDS "s full!" CR>)
		      (T
		       <COND (,HAND-COVER
		       	      <TELL "You're already">)
			     (T
		       	      <SETG HAND-COVER ,PRSO>
		       	      <FSET ,PRSO ,MUNGBIT>
			      <COND (<EQUAL? ,HAND-COVER ,EARS>
				     <TELL ,MUFFLED "'re">)
				    (T
		       	      	     <TELL "Okay, you're now">)>)>
		       <TELL
" covering " D ,HAND-COVER " with " 'HANDS "s." CR>)>)>>

<ROUTINE ITEMS-CARRIED ("AUX" X (CNT 0))
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)
		       (<AND <NOT <FSET? .X ,WORNBIT>>
			     <NOT <EQUAL? .X ,COMIC-BOOK>>>
			<SET CNT <+ .CNT 1>>)>
		 <SET X <NEXT? .X>>>
	 <RETURN .CNT>>

<GLOBAL HAND-COVER <>>

<OBJECT HEAD
	(IN GLOBAL-OBJECTS)
	(DESC "your head")
	(SYNONYM HEAD)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION HEAD-F)>

<ROUTINE HEAD-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSO? ,BLANKET ,SHEET ,SACK>>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Where do you think you are, Traal?" CR>)>>

<OBJECT EYES
	(IN GLOBAL-OBJECTS)
	(DESC "your eyes")
	(SYNONYM EYE EYES)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)
	(ACTION EYES-F)>

<ROUTINE EYES-F ()
	 <COND (<VERB? CLOSE>
		<COND (,GONE-APE
		       <WASTES>)
		      (<FSET? ,EYES ,MUNGBIT>
		       <COND (<EQUAL? ,EYES ,HAND-COVER>
			      <TELL ,HANDS-OVER-EYES>)
			     (T
			      <TELL ,SENILITY-STRIKES>)>)
		      (T
		       <FSET ,EYES ,MUNGBIT>
		       <EYES-ARE-NOW "closed">)>)
	       (<VERB? OPEN>
		<COND (<FSET? ,EYES ,MUNGBIT>
		       <COND (<EQUAL? ,EYES ,HAND-COVER>
			      <TELL ,HANDS-OVER-EYES>)
			     (T
			      <SENSE-AGAIN ,EYES>)>)
		      (T
		       <TELL "They are open!" CR>)>)>>

<ROUTINE EYES-ARE-NOW (STRING)
	  <TELL "Your eyes are now " .STRING ,PERIOD-CR>>

<ROUTINE OPEN-EYES-AND-REMOVE-HANDS ()
	 <FCLEAR ,EYES ,MUNGBIT>
	 <COND (,HAND-COVER
		<FCLEAR ,HAND-COVER ,MUNGBIT>
		<SETG HAND-COVER <>>)>>

<OBJECT EARS
	(IN GLOBAL-OBJECTS)
	(DESC "your ears")
	(SYNONYM EAR EARS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)
	(ACTION EARS-F)>

<ROUTINE EARS-F ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,P-PRSA-WORD ,W?HOLD>>
		<PERFORM ,V?SPUT-ON ,EARS ,HANDS>
		<RTRUE>)
	       (<AND <VERB? UNCOVER>
		     <FSET? ,COTTON-BALLS ,WORNBIT>
		     <NOT ,GONE-APE>>
		<COND (<EQUAL? ,EARS ,HAND-COVER>
		       <SETG HAND-COVER <>>)>
		<PERFORM ,V?REMOVE ,COTTON-BALLS>
		<RTRUE>)>>

<OBJECT NOSE
	(IN GLOBAL-OBJECTS)
	(DESC "your nose")
	(SYNONYM NOSE NOSTRIL)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION NOSE-F)>

<ROUTINE NOSE-F ()
	 <COND (<VERB? BLOW PICK>
		<TELL ,YECHH>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,P-PRSA-WORD ,W?HOLD>>
		<PERFORM ,V?SPUT-ON ,NOSE ,HANDS>
		<RTRUE>)
	       (<AND <VERB? UNCOVER>
		     <FSET? ,CLOTHES-PIN ,WORNBIT>
		     <NOT ,GONE-APE>>
		<COND (<EQUAL? ,NOSE ,HAND-COVER>
		       <SETG HAND-COVER <>>)>
		<PERFORM ,V?REMOVE ,CLOTHES-PIN>
		<RTRUE>)>>

<OBJECT MOUTH
	(IN GLOBAL-OBJECTS)
	(DESC "your mouth")
	(SYNONYM MOUTH LIP LIPS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION MOUTH-F)>

<ROUTINE MOUTH-F ()
	 <COND (<AND <VERB? CLEAN>
		     <FSET? ,LIP-BALM ,WORNBIT>>
		<PERFORM ,V?REMOVE ,LIP-BALM>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,LIP-BALM ,WORNBIT>>
		<ROB ,PROTAGONIST ,TOILET>
		<MOVE ,LIP-BALM ,PROTAGONIST>
		<V-INVENTORY> ;"should say YOU HAVE LIP BALM (SMEARED...)"
		<ROB ,TOILET ,PROTAGONIST>)
	       (<AND <VERB? PUT>
		     <PRSI? ,MOUTH>>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (<VERB? OPEN>
		<TELL "This fails to catch any flies." CR>)>>

<OBJECT KNEECAPS
	(IN GLOBAL-OBJECTS)
	(DESC "your kneecaps")
	(SYNONYM KNEECAP KNEE KNEES)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)>

<OBJECT COCK
	(IN GLOBAL-OBJECTS)
	(DESC "your naughty bits")
	(SYNONYM COCK PENIS BALLS ASS)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION NAUGHTY-BITS-F)>

<OBJECT CUNT
	(IN GLOBAL-OBJECTS)
	(DESC "your naughty bits")
	(SYNONYM CUNT VAGINA PUSSY)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PARTBIT)
	(ACTION NAUGHTY-BITS-F)>

<OBJECT TITS
	(IN GLOBAL-OBJECTS)
	(DESC "your naughty bits")
	(SYNONYM TIT TITS BREAST BOSOM)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT PLURALBIT PARTBIT)
	(ACTION NAUGHTY-BITS-F)>

<ROUTINE NAUGHTY-BITS-F ()
	 <COND (<AND <NOUN-USED ,W?PUSSY ,CUNT>
		     <NOT <ADJ-USED ,A?MY>>
		     <VISIBLE? ,PAINTING>>
		<COND (<PRSO? ,CUNT>
		       <PERFORM-PRSA ,PAINTING ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSI ,PAINTING>
		       <RTRUE>)>)
	       (T
	 	<TELL
"You don't need to refer to " 'COCK " to complete " ,LGOP-CAPS ,PERIOD-CR>)>>

<OBJECT PROTAGONIST
	(IN JOES-BAR)
	(SYNONYM PROTAG)
	(DESC "it")
	(FLAGS NDESCBIT INVISIBLE ACTORBIT)>
 
<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM I ME MYSELF SELF)
	(DESC "yourself")
	(FLAGS ;ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)>

<ROUTINE ME-F () 
	 <COND (<VERB? TELL>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>
		<STOP>)
	       (<VERB? RELIEVE>
		<V-PEE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,ME>
		     <NOT ,MALE>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<PERFORM ,V?FUCK ,ME>
		<RTRUE>)
	       (<AND <VERB? TOUCH FUCK EAT>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL
"Encouraging such behavior would endanger the possibility of landing
a lucrative Hollywood contract to make a film of " ,LGOP-CAPS ,PERIOD-CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<AND <VERB? SHOW>
		     <PRSI? ,ME>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>)
	       (<VERB? MOVE>
		<V-WALK-AROUND>)
	       (<VERB? SEARCH>
		<V-INVENTORY>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (,GONE-APE
		       <TELL "You've gone ape!" CR>)
		      (T
		       <TELL "You're wearing">
		       <COND (<FSET? ,WHITE-SUIT ,WORNBIT>
			      <TELL AR ,WHITE-SUIT>)
			     (T
			      <TELL AR ,GARMENT>)>)>)
	       (<VERB? KILL MUNG>
		<JIGS-UP "Done.">)
	       (<VERB? FIND WHERE>
		<TELL "You're in" TR ,HERE>)
	       (<VERB? MEASURE>
		<TELL "You don't measure up." CR>)
	       (<AND <VERB? UNTIE>
		     ,BODY-TIED-TO-SLAB>
		<COND (,GONE-APE
		       <PERFORM-PRSA ,YOUR-BODY>
		       <RTRUE>)
		      (T
		       <YUKS>)>)
	       (<AND <VERB? TIE>
		     <PRSI? ,FIRST-SLAB ,SECOND-SLAB>>
		<COND (<AND ,BODY-TIED-TO-SLAB
			    <NOT ,GONE-APE>>
		       <TELL "You are!" CR>)
		      (T
		       <TELL ,YOU-CANT "tie yourself down!" CR>)>)
	       (<VERB? FOLLOW>
		<TELL "Like most computers, I don't have legs." CR>)>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM PLACE LOCATI AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK LOOK-INSIDE EXAMINE>
		<V-LOOK>)
	       (<VERB? ENTER WALK-TO>
		<V-WALK-AROUND>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<DO-WALK ,P?OUT>)
	       (<VERB? SEARCH>
		<COND (<EQUAL? ,HERE ,EXIT-SHOP>
		       <PERFORM-PRSA ,DUST>
		       <RTRUE>)
		      (T
		       <TELL ,NOTHING-NEW>)>)
	       ;(<VERB? WALK-AROUND>
                <TELL "Walking around here">
		<HO-HUM>
		<TELL " To move elsewhere, type the desired direction." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,GLOBAL-ROOM>>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?THROW>
		       <PERFORM ,V?THROW ,PRSO>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)>>

<OBJECT HOUSE
	(IN LOCAL-GLOBALS)
	(DESC "house")
	(SYNONYM HOUSE HOME)
	(ADJECTIVE SMALL RICKETY MAD SCIENTIST PLASTIC)
	(ACTION HOUSE-F)>

<ROUTINE HOUSE-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<OR <EQUAL? ,HERE ,BEDROOM ,TEENSY-WEENSY-HOUSE>
			   <EQUAL? ,HERE ,LABORATORY ,LOOKS-CAN-BE-DECEIVING>>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,FRONT-DOOR>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,BACK-DOOR>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,CLEVELAND>
		       <DO-WALK ,P?NE>)
		      (<EQUAL? ,HERE ,BEDROOM ,GARDEN>
		       <DO-WALK ,P?WEST>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,LABORATORY ,BEDROOM>
		       <TELL ,CANT-FROM-HERE>)
		      (<EQUAL? ,HERE ,TEENSY-WEENSY-HOUSE ,LABORATORY>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,FRONT-DOOR ,BACK-DOOR ,GARDEN>
		       <TELL ,CANT-FROM-HERE>)
		      (T
		       <V-LOOK>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

<OBJECT SIGN
	(IN LOCAL-GLOBALS)
	(DESC "sign")
	(SYNONYM SIGN)
	(ADJECTIVE LARGE RED FADED)
	(FLAGS READBIT)
	(ACTION SIGN-F)>

<ROUTINE SIGN-F ("AUX" NUM)
	 <SET NUM <CANAL-LOC>>
	 <COND (<AND <EQUAL? ,HERE ,CANAL>
		     <NOT <EQUAL? .NUM 15>>>
		<CANT-SEE ,SIGN>)
	       (<VERB? READ>
		<COND (<EQUAL? ,HERE ,END-OF-HALLWAY>
		       <TELL "\"Up To Observation Room.\"" CR>)
		      (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <TELL "\"Down to Cells.\"" CR>)
		      (<EQUAL? ,HERE ,EXIT-SHOP>
		       <TELL "\"E" ,BOUGHT-AND-SOLD ".\"" CR>)
		      (<EQUAL? ,HERE ,VIZICOMM-BOOTH>
		       <TELL "\"Out of order.\"" CR>)
		      (<EQUAL? ,HERE ,SOUTH-POLE>
		       <TELL
"\"Martian Orphanages, Inc.|
   South Polar Branch\"" CR>)
		      (<EQUAL? ,HERE ,PENGUIN-PARK>
		       <TELL
"\"Give generously to the Penguin Retirement Fund.\"" CR>)
		      (<EQUAL? ,HERE ,CANAL ,WATTZ-UPP-DOCK>
		       <TELL
"The sign has no writing, only the skull and crossbones." CR>)>)>>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(DESC "stair")
	(SYNONYM STAIR STAIRS STAIRW STEP)
	(ADJECTIVE WINDING)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <COND (<NOT <BEDROOM-EXIT-F T>>
			      <RTRUE>)>
		       <GOTO ,TEENSY-WEENSY-HOUSE>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<AND <VERB? THROW>
		     <PRSI? ,STAIRS>>
		<WASTES>)>>

<OBJECT WINDOW
	(IN LOCAL-GLOBALS)
	(DESC "window")
	(SYNONYM WINDOW VIEWPORT GLASS)
	(ADJECTIVE RECTAN STAINED GLASS BARRED SMALL GRIMY)
	(ACTION WINDOW-F)>

<ROUTINE WINDOW-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <SETG SEEN-EXAMINATION-ROOM T>
		       <TELL ,YOU-SEE " a large room below. ">
		       <EXAMINATION-ROOM-DESC T>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <MOVE ,FORD ,HERE>
		       <COND (<FSET? ,HEADLIGHT ,TRYTAKEBIT>
			      <MOVE ,HEADLIGHT ,HERE>)>
		       <MOVE ,FORD ,HERE>
		       <TELL
"A car is parked on the street, twenty feet below. It's a Ford, a 1933 Ford
... and one of its " 'HEADLIGHT "s is ">
		       <COND (<AND <IN? ,HEADLIGHT ,HERE>
				   <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
			      <TELL "loose">)
			     (T
			      <TELL "missing">)>
		       <TELL ,PERIOD-CR>)
		      (<EQUAL? ,HERE ,HOLD>
		       <TELL ,YOU-SEE " Saturn and her ample rings.">
		       <COND (<NOT <EQUAL? ,SPACESHIP-SCENE-STATUS 1>>
			      <TELL
" Much closer, no more than a hundred feet away, is"
A ,PASSENGER-SHIP ". Judging by the steam blowing from
her ion engines, she's preparing to depart.">)>
		       <CRLF>)
		      (<EQUAL? ,HERE ,JOES-BAR>
		       <TELL
"It's raw and blowy outside. Little whirlpools of dust dance by." CR>)
		      (<EQUAL? ,HERE ,SOUTH-POLE>
		       <COND (<FSET? ,ORPHANAGE-FOYER ,TOUCHBIT>
			      <TELL "The window is fogged." CR>)
			     (T
		       	      <SETG COTTON-BALLS-SEEN T>
			      <MOVE ,COTTON-BALLS ,HERE> ;"so you can refer"
			      <TELL
,YOU-SEE " a " 'COTTON-BALLS " sitting in an entrance foyer." CR>)>)
		      (<EQUAL? ,HERE ,ORPHANAGE-FOYER>
		       <TELL ,YOU-SEE " an icy plain." CR>)
		      (<EQUAL? ,HERE ,MAIN-HALL-OF-PALACE>
		       <TELL "Colored light spills through the window." CR>)>)
	       (<VERB? OPEN>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL ,ALREADY-IS>)
		      (T
		       <TELL "It's not that kind of window." CR>)>)
	       (<VERB? CLOSE>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL "It seems stuck." CR>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<AND <VERB? PUT-THROUGH PUT>
		     <PRSI? ,WINDOW>
		     <EQUAL? ,HERE ,BEDROOM>>
		<COND (<PRSO? ,HANDS>
		       <TELL ,HUH>)
		      (<IN? ,PROTAGONIST ,BED>
		       <CANT-REACH ,PRSI>)
		      (<AND <PRSO? ,SHEET>
			    <OR ,SHEET-HANGING
				,SHEET-TIED>>
		       <RFALSE> ;"SHEET-F handles it")
		      (T
		       <REMOVE ,PRSO>
		       <PRONOUN>
		       <TELL " land">
		       <COND (<NOT <FSET? ,PRSO ,PLURALBIT>>
			      <TELL "s">)>
		       <TELL
" on the street below. An urchin dashes up and runs off with" TR ,PRSO>)>)
	       (<AND <VERB? EMPTY-FROM>
		     <PRSI? ,WINDOW>
		     <EQUAL? ,HERE ,BEDROOM>>
		<PERFORM ,V?EMPTY ,PRSO ,WINDOW>
		<RTRUE>) 
	       (<VERB? ENTER EXIT DISEMBARK LEAP-OFF>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <COND (,SHEET-HANGING
			      <PERFORM ,V?CLIMB-DOWN ,SHEET>
			      <RTRUE>)
			     (T
		       	      <PLUMMET-TO-PAVEMENT>)>)
		      (<EQUAL? ,HERE ,SOUTH-POLE ,ORPHANAGE-FOYER>
		       <TELL "It's barred!" CR>)
		      (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <DO-WALK ,P?WEST>)
		      (T
	               <DO-FIRST "open" ,WINDOW>)>)>>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(DESC "tree")
	(SYNONYM TREE TREES)
	(ACTION TREE-F)>

<ROUTINE TREE-F ()
	 <COND (<VERB? CLIMB CLIMB-UP>
		<TELL "The trees are all unclimbable." CR>)>>

<OBJECT HOLE
	(IN LOCAL-GLOBALS)
	(SDESC "black circle")
	(SYNONYM HOLE CIRCLE)
	(ADJECTIVE BLACK WHITE)
	(ACTION HOLE-F)>

<GLOBAL HOLE-MOVE <>>

<ROUTINE HOLE-F ("AUX" OLD-HERE)
	 <COND (<OR <AND <NOT <CIRCLE-ISNT-BLACK>>
			 <PRSO? ,HOLE>
			 <EQUAL? <GET ,P-ADJW 0> ,A?WHITE>>
		    <AND <NOT <CIRCLE-ISNT-BLACK>>
			 <PRSI? ,HOLE>
			 <EQUAL? <GET ,P-ADJW 1> ,A?WHITE>>
		    <AND <CIRCLE-ISNT-BLACK>
			 <PRSO? ,HOLE>
			 <EQUAL? <GET ,P-ADJW 0> ,A?BLACK>>
		    <AND <CIRCLE-ISNT-BLACK>
			 <PRSI? ,HOLE>
			 <EQUAL? <GET ,P-ADJW 1> ,A?BLACK>>>
		<CANT-SEE ,HOLE>)
	       (<HOLE-INVISIBLE>
		<CANT-SEE ,HOLE>)
	       (<AND <EQUAL? ,HERE ,CELL>
		     <NOUN-USED ,W?HOLE ,HOLE>
		     <VERB? BOARD ENTER WALK-TO LOOK-INSIDE>>
		<DO-WALK ,P?UP>)
	       (<AND <EQUAL? <LOC ,PROTAGONIST> ,CAGE ,FIRST-SLAB ,SECOND-SLAB>
		     <TOUCHING? ,HOLE>>
		<CANT-REACH ,HOLE>
		<RTRUE>)
	       (<VERB? STAND-ON ENTER BOARD>
		<COND (<CIRCLE-ISNT-BLACK>
		       <TELL ,NOTHING-HAPPENS>
		       <RTRUE>)
		      (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <NOT-GOING-ANYWHERE>
		       <RTRUE>)>
	        <FALL-THROUGH-HOLE>
		<SETG LONG-CORRIDOR-LOC 1>
		<SETG MAD-SCIENTIST-COUNTER 0>
		<SETG IMPATIENCE-COUNTER 0>
		<DEQUEUE I-MAD-SCIENTIST>
		<SET OLD-HERE ,HERE>
		<COND (<EQUAL? ,HERE ,LONG-CORRIDOR>
		       <TELL
"Geronimo!|
   Yow! You appear in midair, high above a canal-studded desertscape.
The ground is approaching uncomfortably fast.|
   Caw! Caw! A pterodactyl snatches you">
		       <AND-SIDEKICK>
		       <TELL " in midair and deposits you safely in" ,ELLIPSIS>
		       <COND (<AND <FSET? ,MY-KIND-OF-DOCK ,TOUCHBIT>
				   <PROB 60>>
			      <GOTO ,MY-KIND-OF-DOCK>)
			     (<AND <FSET? ,OASIS ,TOUCHBIT>
				   <PROB 40>>
			      <GOTO ,OASIS>)
			     (T
			      <GOTO ,RUINED-CASTLE-2>)>)
		      (T
		       <GOTO <GETP ,HERE ,P?HOLE-DESTINATION>>)>
		<COND (<AND <EQUAL? .OLD-HERE ,WELL-BOTTOM>
			    <IN? ,SIDEKICK ,WELL-BOTTOM>>
		       <SETG HOLE-MOVE T> ;"the call to GOTO, above, clears it"
		       <SIDEKICK-FOLLOWS-YOU>
		       <SETG HOLE-MOVE <>>)>
		<RTRUE>)	       
	       (<VERB? LOOK-UNDER TAKE>
		<TELL "It's not liftable." CR>)
	       (<AND <VERB? POUR RUB PUT-ON>
		     <NOUN-USED ,W?STAIN ,STAIN>
		     <PRSO? ,STAIN>>
		<APPLY-STAIN ,HOLE>)
	       (<AND <VERB? PUT PUT-ON PUT-THROUGH>
		     <PRSI? ,HOLE>>
		<COND (<CIRCLE-ISNT-BLACK>
		       <WASTES>)
		      (<PRSO? ,SOD>
		       <RFALSE> ;"SOD-F handles it")
		      (T
		       <COND (<EQUAL? ,HERE ,LONG-CORRIDOR>
			      <REMOVE ,PRSO> ;"Geronimo!")
			     (T
		       	      <COND (<AND <PRSO? ,TORCH>
					  <EQUAL? ,HERE ,WELL-BOTTOM>>
		       		     <TORCH-OFF>)>
			      <MOVE ,PRSO <GETP ,HERE ,P?HOLE-DESTINATION>>)>
		       <NON-DIMENSIONAL-JOURNEY>)>)
	       (<CIRCLE-ISNT-BLACK>
		<RFALSE>)
	       (<VERB? REACH-IN TOUCH>
		<TELL ,HAND-DWINDLES>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL ,STARING-INTO-VOID>)
	       (<VERB? MEASURE>
		<PERFORM-PRSA ,FLEXIBLE-HOLE>
		<RTRUE>)>>

<ROUTINE HOLE-INVISIBLE ()
	 <COND (<OR <AND <EQUAL? ,HERE ,GARDEN>
		     	 <NOT <FSET? ,SOD ,MUNGBIT>>>
		    <AND <EQUAL? ,HERE ,CELL>
		         <NOT ,HOLE-OPEN>>
	            <AND <EQUAL? ,HERE ,LONG-CORRIDOR>
		     	 <NOT <EQUAL? ,LONG-CORRIDOR-LOC 3>>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NON-DIMENSIONAL-JOURNEY ()
	 <TELL
"You get all cross-eyed trying to follow the non-dimensional journey of"
T ,PRSO " into" T ,HOLE ". When you get your eyeballs untangled again,"
T ,PRSO " is gone." CR>>

<ROUTINE FALL-THROUGH-HOLE ()
	 <SETG HOLE-MOVE T>
	 <SETG RAFT-HELD <>>
	 <TELL
"You're sucked into the hole in a direction that isn't down, but neither
is it one of the other directions with which you're familiar.">
	 <COND (<ULTIMATELY-IN? ,WHITE-SUIT>
		<MOVE ,WHITE-SUIT ,AT-MAIN-HATCH>
		<FCLEAR ,WHITE-SUIT ,TOUCHBIT>
		<FCLEAR ,WHITE-SUIT ,WORNBIT>
		<COND (<VISIBLE? ,WHITE-SUIT>
		       <TELL
" Oddly, your " D ,WHITE-SUIT " vanishes without a trace.">)>)>
	 <CRLF> <CRLF>>

<ROUTINE TOUCHING? (THING)
	 <COND (<AND <PRSO? .THING>
		     <OR <EQUAL? ,PRSA ,V?TAKE ,V?TOUCH ,V?SHAKE>
			 <EQUAL? ,PRSA ,V?CLEAN ,V?KISS ,V?SWIM>
			 <EQUAL? ,PRSA ,V?PUSH ,V?CLOSE ,V?LOOK-UNDER>
			 <EQUAL? ,PRSA ,V?MOVE ,V?OPEN ,V?KNOCK>
			 <EQUAL? ,PRSA ,V?SET ,V?SHAKE ,V?RAISE>
			 <EQUAL? ,PRSA ,V?UNLOCK ,V?LOCK ,V?CLIMB-UP>
			 <EQUAL? ,PRSA ,V?CLIMB ,V?CLIMB-DOWN ,V?CLIMB-ON>
			 <EQUAL? ,PRSA ,V?BOARD ,V?ENTER ,V?ON>
			 <EQUAL? ,PRSA ,V?OFF ,V?SET ,V?THROW>
			 <EQUAL? ,PRSA ,V?TASTE ,V?FUCK ,V?RAPE>
			 <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?STAND-ON ,V?TIE>
			 <EQUAL? ,PRSA ,V?MUNG ,V?KICK ,V?KILL>
			 <EQUAL? ,PRSA ,V?KNOCK ,V?CUT ,V?WHIP>
			 <EQUAL? ,PRSA ,V?BITE ,V?PUSH>>>
		<RTRUE>)
	       (<AND <PRSI? .THING>
		     <VERB? GIVE PUT PUT-ON>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-CATACOMBS ()
	 <COND (<EQUAL? ,HERE ,CATACOMBS ,WELL-BOTTOM ,LADDER-ROOM>
		<RTRUE>)
	       (<EQUAL? ,HERE ,BURIAL-CHAMBER ,FORGOTTEN-STOREHOUSE>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-SPACE? ()
	 <COND (<OR <EQUAL? ,HERE ,HOLD ,STABLE ,AT-MAIN-HATCH>
		    <EQUAL? ,HERE ,LONG-CORRIDOR ,IN-SPACE ,SPACE-YACHT>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE CANT-SEE ("OPTIONAL" (OBJ <>) (STRING <>))
	 <SETG P-WON <>>
	 <TELL ,YOU-CANT>
	 <COND (<EQUAL? .OBJ ,ODOR>
		<TELL "smell">)
	       (T
		<TELL "see">)>
	 <COND (<OR <NOT .OBJ>
		    <AND .OBJ
			 <NOT <NAME? .OBJ>>>>
		<TELL " any">)>
	 <COND (<NOT .OBJ>
		<TELL " " .STRING>)
	       (<EQUAL? .OBJ ,PRSI>
		<PRSI-PRINT>)
	       (T
		<PRSO-PRINT>)>
	 <TELL " here." CR>
	 <STOP>>

<ROUTINE CANT-VERB-A-PRSO (STRING)
	 <TELL ,YOU-CANT .STRING A ,PRSO "!" CR>>

<ROUTINE OPEN-YOUR-EYES! ()
	 <COND (<FSET? ,EYES ,MUNGBIT>
		<DO-FIRST "open" ,EYES>)
	       (T
		<DO-FIRST "uncover" ,EYES>)>>

<ROUTINE NOW-TIED (OBJ)
	 <TELL "Okay," T ,PRSO " is now tied to" TR .OBJ>>

<ROUTINE TELL-HIT-HEAD ()
	 <TELL
"You bang your bean against" T ,PRSO " as you attempt this." CR>>

<ROUTINE NOUN-USED (TEST-NOUN OBJ)
	 <COND (<AND <PRSO? .OBJ>
		     <EQUAL? <GET ,P-NAMW 0> .TEST-NOUN>>
		<RTRUE>)
	       (<AND <PRSI? .OBJ>
		     <EQUAL? <GET ,P-NAMW 1> .TEST-NOUN>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE ADJ-USED (TEST-ADJ)
	 <COND (<EQUAL? .TEST-ADJ <GET ,P-ADJW 0> <GET ,P-ADJW 1>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OFF-VEHICLE? (OBJ) ;"tells to print GET OFF versus GET OUT OF"
	 <COND (<OR <EQUAL? .OBJ ,STOOL ,TOILET ,FRONT-STOOP>
		    <EQUAL? .OBJ ,FIRST-SLAB ,SECOND-SLAB>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OPEN-CLOSED (OBJ)
	 <COND (<FSET? .OBJ ,OPENBIT>
		<TELL "open">)
	       (T
		<TELL "closed">)>>

<ROUTINE WEE ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE IN-YOUR-PACKAGE (STRING)
	 <TELL "This is the " .STRING>
	 <IN-PACKAGE>>

<ROUTINE IN-PACKAGE ()
	 <TELL " that came in your " ,LGOP-CAPS " package.">>

<ROUTINE HIS-HER ("OPTIONAL" (CAP-H <>))
	 <COND (.CAP-H
		<TELL "H">)
	       (T
		<TELL "h">)>
	 <COND (,MALE
		<TELL "is">)
	       (T
		<TELL "er">)>>

<ROUTINE HER-HIS ("OPTIONAL" (CAP-H <>))
	 <COND (.CAP-H
		<TELL "H">)
	       (T
		<TELL "h">)>
	 <COND (,MALE
		<TELL "er">)
	       (T
		<TELL "is">)>>

<ROUTINE HIM-HER ()
	 <COND (,MALE
		<TELL "him">)
	       (T
		<TELL "her">)>>

<ROUTINE HER-HIM ()
	 <COND (,MALE
		<TELL "her">)
	       (T
		<TELL "him">)>>

<ROUTINE HE-SHE ("OPTIONAL" (CAP <>))
	 <COND (,MALE
		<COND (.CAP
		       <TELL "H">)
		      (T
		       <TELL "h">)>)
	       (T
		<COND (.CAP
		       <TELL "Sh">)
		      (T
		       <TELL "sh">)>)>
	 <TELL "e">>

<ROUTINE SHE-HE ("OPTIONAL" (CAP <>))
	 <COND (,MALE
		<COND (.CAP
		       <TELL "Sh">)
		      (T
		       <TELL "sh">)>)
	       (T
		<COND (.CAP
		       <TELL "H">)
		      (T
		       <TELL "h">)>)>
	 <TELL "e">>

<ROUTINE CANT-REACH (OBJ)
	 <TELL ,YOU-CANT "reach" T .OBJ>
	 <COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		<TELL " from" T <LOC ,PROTAGONIST>>)>
	 <TELL ,PERIOD-CR>>

<ROUTINE EAGERLY-ACCEPTS ()
	 <MOVE ,PRSO ,PRSI>
	 <TELL "Eagerly," T ,PRSI " accepts" T ,PRSO>>

<ROUTINE NOT-ON-GROUND (VEHICLE)
	 <TELL "But" T .VEHICLE " isn't on the ground!" CR>>

<ROUTINE AND-SIDEKICK ("OPTIONAL" (NEW-SIDEKICK-LOC <>))
	 <COND (<VISIBLE? ,SIDEKICK>
		<COND (.NEW-SIDEKICK-LOC
		       <MOVE ,SIDEKICK .NEW-SIDEKICK-LOC>)>
		<TELL " and " D ,SIDEKICK>)>>

<ROUTINE PLAYER-CANT-SEE ()
	 <COND (<OR <FSET? ,EYES ,MUNGBIT>
		    <EQUAL? ,HAND-COVER ,EYES>>
		<OPEN-YOUR-EYES!>)
	       (<NOT ,LIT>
		<TELL ,TOO-DARK CR>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-FIRST (STRING "OPTIONAL" (OBJ <>))
	 <TELL ,YOULL-HAVE-TO .STRING>
	 <COND (.OBJ
		<TPRINT .OBJ>)>
	 <TELL " first." CR>>

<ROUTINE NOT-IN ()
	 <TELL "But" T ,PRSO " isn't ">
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "being held by">)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<TELL "on">)
	       (T
		<TELL "in">)>
	 <TELL TR ,PRSI>>

<ROUTINE NO-LID ()
	 <TELL "The " D ,PRSO " has no lid." CR>>

<ROUTINE SORE (STRING)
	 <TELL "You begin to get a sore " .STRING ,PERIOD-CR>>

<ROUTINE CANT-USE-THAT-WAY (STRING)
	 <TELL "[" ,YOU-CANT "use " .STRING " that way.]" CR>>

<ROUTINE RECOGNIZE ()
	 <SETG P-WON <>>
	 <TELL "[That sentence isn't one I recognize.]" CR>>

<ROUTINE EXPLETIVE ()
	 <TELL " \"Oh ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL "shucks">)
	       (<EQUAL? ,NAUGHTY-LEVEL 1>
		<TELL "damn">)
	       (T
		<TELL "shit">)>
	 <TELL "! ">>

<ROUTINE PRONOUN ()
	 <COND (<PRSO? ,ME>
		<TELL "You">)
	       (<FSET? ,PRSO ,PLURALBIT>
		<TELL "They">)
	       (<FSET? ,PRSO ,FEMALEBIT>
		<TELL "She">)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "He">)
	       (T
		<TELL "It">)>>


<ROUTINE REFERRING ("OPTIONAL" (HIM-HER <>))
	 <TELL "I don't see wh">
	 <COND (.HIM-HER
		<TELL "o">)
	       (T
		<TELL "at">)>
	 <TELL " you're referring to." CR>>

<ROUTINE NO-ONE-HERE (STRING)
	 <TELL "There's no one here to " .STRING ,PERIOD-CR>>

<ROUTINE SEE-MANUAL (STRING)
	 <TELL
"[You need quotes to " .STRING " See the instruction manual section
entitled \"Communicating With Infocom's Interactive Fiction.\"]" CR>>

<ROUTINE UNIMPORTANT-THING-F ()
	 <TELL "That's not important; leave it alone." CR>>

<GLOBAL TOO-DARK "It's too dark to see a thing.">

<GLOBAL YNH "You're not holding">

<GLOBAL THERES-NOTHING "There's nothing ">

<GLOBAL YOU-SEE "You can see">

<GLOBAL IT-SEEMS-THAT "It seems that">

<GLOBAL YOU-CANT-SEE-ANY "You can't see any ">

<GLOBAL YOU-CANT "You can't ">

<GLOBAL YOULL-HAVE-TO "You'll have to ">

<GLOBAL CATACOMBS-WATER-DESC
"As the result of an ancient leak, the catacombs are knee deep in warm,
brackish canal water.">

<GLOBAL ITS-ENGRAVED "There's an engraving on its side.">

<GLOBAL LGOP-CAPS "LEATHER GODDESSES OF PHOBOS">

<GLOBAL STICK-IT-IN-POCKET " stick it back in your back pocket">

<GLOBAL SPREAD-APART " spread apart to form an opening">

<GLOBAL PLEASURE-PALACE-DESC
" the arching towers and curving domes of the notorious Pleasure Palace of ">

<GLOBAL ATTACK-FLEET " Main Attack Fleet">

<GLOBAL MUFFLED "Many sounds seem muffled now that you">

<GLOBAL ABOUT-TO-KISS ", but just as you are about to kiss the frog ">

<GLOBAL PRIVATE-BOUDOIR " extremely secret and private boudoir">

<GLOBAL 45-DEGREE-ANGLE " forty-five degree angle">

<GLOBAL HIT-RETURN ". Hit the RETURN/ENTER key to ">

<GLOBAL BOUGHT-AND-SOLD "xits bought and sold">

<GLOBAL BATTLESHIP-DESC
"Hanging from the base of the long, potent-looking battleship are two
pendulous, brimming fuel tanks.">

<GLOBAL EVOLVED " evolved eating flies weighing a quarter of a">

<GLOBAL OOZY-WITH-SLIME "The ground is oozy with proto-slime.">

<GLOBAL VIZICOMM-DESC
" an ordinary pay vizicomm, with a handset, coin slot, dial, coin return
knob, and coin return box.">

<GLOBAL SIGN-AND-STAIRS
". A sign is posted next to the stairs which lead both upwards and downwards.">

<GLOBAL PROPRIETOR-STIRS "The proprietor stirs somewhat from his lethargy. \"">

<GLOBAL WRITING-CHANGES "The writing on the button changes as you press it">

<GLOBAL PINNED ", pinned to the dock by the current.|">

<GLOBAL KEEP-IT-FROM-FLOATING-AWAY
". To keep it from floating away, you pull the raft out of the water.|">

<GLOBAL ALREADY-IN-MODE "You are already in that mode.|">

<GLOBAL LOOK-AROUND "Look around you.|">

<GLOBAL CANT-FROM-HERE "You can't do that from here.|">

<GLOBAL CANT-GO "You can't go that way.|">

<GLOBAL HOLDING-IT "You're holding it!|">

<GLOBAL CANT-SMELL "You can't smell any odor here.|">

<GLOBAL MISSIONARY-ONLY
"Sorry -- nothing beyond the missionary position in SUGGESTIVE level.|">

<GLOBAL NOUN-MISSING "[There seems to be a noun missing in that sentence.]|">

<GLOBAL ONLY-BLACKNESS "You see only blackness.|">

<GLOBAL SENILITY-STRIKES "You already did that. Senility strikes again!|">

<GLOBAL PART-OF-VIZICOMM "You can't take that -- it's part of the vizicomm!|">

<GLOBAL PERIOD-CR ".|">

<GLOBAL ELLIPSIS "...||">

<GLOBAL HANDS-OVER-EYES
"That would accomplish nothing, since you're covering
your eyes with your hands.|">

<GLOBAL MORE-ROYAL-BLOOD
"It would take considerably more royal blood than you've got to wear
this royal crown.|">

<GLOBAL GIMME-TROUBLE
"\"Don't gimme trouble -- just gimme a number between 1 and 8379.\"|">

<GLOBAL TWICE-AS-LOUD "t begins crying twice as loudly as before.|">

<GLOBAL ONLY-ONE-THING-IN-COMPARTMENT
"You can only fit one thing in the odd machine at a time.|">

<GLOBAL NOTHING-HAPPENS "Nothing happens.|">

<GLOBAL HORSE-CANT-FIT "The horse can't fit through there!|">

<GLOBAL FAILED "Failed.|">

<GLOBAL OK "Okay.|">

<GLOBAL HUH "Huh?|">

<GLOBAL YECHH "Yechh.|">

<GLOBAL ALREADY-IS "It already is!|">

<GLOBAL NOTHING-NEW "This reveals nothing new.|">

<GLOBAL ONLY-WITH-A-RAKE "You can only rake with a rake.|">

<GLOBAL LOOKS-UNAPPETIZING
" looks unappetizing, but smells deliciously familiar.|">

<GLOBAL NO-VERB "[There was no verb in that sentence!]|">

<GLOBAL DONT-WANT-TO "You don't want to. Believe me.|">

<GLOBAL DEXTERITY "You don't have enough dexterity.|">

<GLOBAL NO-STEERING "There's no obvious steering mechanism.|">

<GLOBAL PFFT "\"Phfffft!\" The torch goes out.|">

<GLOBAL TRELLIS-TOO-WIDE "The trellis is too wide to fit in the hole.|">

<GLOBAL LEAVE-ME-ALONE
"\"Leave me alone! I'm manipulating the budget for the invasion. I can't
believe how much neuro-tinglers cost these days...\"|">

<GLOBAL HAND-DWINDLES
"Your hand dwindles disorientingly to a point, like railroad tracks
vanishing toward the horizon.|">

<GLOBAL STARING-INTO-VOID
"It's like staring into an eternal void of blackest infinity sucking up all
life and thought and hope and being -- or, like what you see after getting
your face smashed in a bar fight. You can pick the metaphor you're most
familiar with.|">