HLUOPT3 ;CIOFO-O/LJA - Delete 772, 773 Entries w/Direct Kills ;05/15/2008 16:16
 ;;1.6;HEALTH LEVEL SEVEN;**109,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ; WARNING!  No locking used in DEL772 and DEL773.  You MUST already
 ;           have the entry lock before calling here, (or be willing to
 ;           accept the consequences.)
 ;
 ; WARNING!  DEL772 and DEL773 does NOT update piece 4 (number entries)
 ;           of the file's zero node.  Be sure to do this elsewhere.
 ;
 ;
DEL772(IEN772) ; Delete 772 entry using kill commands...  (See WARNINGS above)
 N D0,D2,DP,IEN773,P01,P03,P06,P08,P11,PP1,P22
 ;
 ; Does 773 entry exist?
 S IEN773=$O(^HLMA("B",IEN772,0))
 I IEN773,'$D(^HLMA(+IEN773,0)) D
 .  KILL ^HLMA("B",IEN772,IEN773)
 .  S IEN773=""
 QUIT:IEN773  ;->
 ;
 ; Every field value must be set so as not to be null!!!
 ;
 ; Get 0 node data and pieces...
 S D0=$G(^HL(772,+IEN772,0))
 S P01=+$P(D0,U),P03=+$P(D0,U,3)
 S P06=$P(D0,U,6),P06=$S(P06]"":P06,1:" ")
 S P08=+$P(D0,U,8),P011=+$P(D0,U,11)
 ;
 ;Get 2 node data and piece
 S D2=$G(^HL(772,+IEN772,2))
 S P22=+$P(D2,U,2)
 ;
 ; Get P node data and piece...
 S DP=$G(^HL(772,+IEN772,"P"))
 S PP1=+$P(DP,U)
 ;
 ; Kill xrefs...
 KILL ^HL(772,"A-XMIT-OUT",P011,IEN772)
 KILL ^HL(772,"AC","I",P03,IEN772)
 KILL ^HL(772,"AC","O",P03,IEN772)
 KILL ^HL(772,"AF",PP1,IEN772)
 KILL ^HL(772,"AH",P03,P06,IEN772)
 KILL ^HL(772,"AI",P08,IEN772)
 KILL ^HL(772,"B",P01,IEN772)
 KILL ^HL(772,"C",P06,IEN772)
 KILL ^HLMA("AI",P22,772,IEN772)
 ;
 ; Remove data...
 KILL ^HL(772,IEN772)
 ;
 QUIT
 ;
DEL773(IEN773) ; Delete 773 entry using kill commands...  (See WARNINGS above)
 N D0,D2,DP,DS,P01,P02,P07,P06,P012,PP1,PS1,P22
 ;
 ; Every field value must be set so as not to be null!!!
 ;
 ; Get 0 node data and pieces...
 S D0=$G(^HLMA(IEN773,0))
 S P01=+$P(D0,U),P02=$P(D0,U,2),P02=$S(P02]"":P02,1:" ")
 S P07=+$P(D0,U,7),P06=+$P(D0,U,6),P012=+$P(D0,U,12)
 ;
 ;
 ;Get 2 node data and piece
 S D2=$G(^HLMA(IEN773,2))
 S P22=+$P(D2,U,2)
 ;
 ; Get P node data and piece...
 S DP=$G(^HLMA(IEN773,"P"))
 S PP1=+DP
 ;
 ; Get S node data and piece...
 S DS=$G(^HLMA(IEN773,"S"))
 S PS1=+DS
 ;
 ; Kill xrefs...
 KILL ^HLMA("AC","I",P07,IEN773)
 KILL ^HLMA("AC","O",P07,IEN773)
 KILL ^HLMA("AD",PS1,IEN773)
 KILL ^HLMA("AF",P06,IEN773)
 KILL ^HLMA("AG",PP1,IEN773)
 KILL ^HLMA("AH",P012,P02,IEN773)
 KILL ^HLMA("B",P01,IEN773)
 KILL ^HLMA("C",P02,IEN773)
 KILL ^HLMA("AI",P22,773,IEN773)
 ;
 ; patch HL*1.6*142 start
 N HDR,FLD
 S HDR=$G(^HLMA(IEN773,"MSH",1,0))
 I HDR]"" D
 . I $G(^HLMA(IEN773,"MSH",2,0))]"" D
 .. S HDR=HDR_$G(^HLMA(IEN773,"MSH",2,0))
 . S FLD=$E(HDR,4)
 . I FLD]"" D
 .. S HDR=$P(HDR,FLD,3,6)
 .. K:HDR]"" ^HLMA("AH-NEW",HDR,P02,IEN773)
 ; patch HL*1.6*142 end
 ;
 ; Remove data...
 KILL ^HLMA(IEN773)
 ;
 QUIT
 ;
EOR ;HLUOPT3 - Delete 772, 773 Entries w/Direct Kills ;12/30/02 15:15
