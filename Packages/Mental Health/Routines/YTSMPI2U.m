YTSMPI2U ;SLC/LLH - Score MMPI-2-RF ; 01/08/2016
 ;;5.01;MENTAL HEALTH;**123**;DEC 30,1994;Build 73
 ;
 ;Public, Supported ICRs
 ; #2056 - Fileman API - $$GET1^DIQ
 ;
 Q
 ;
ADDSP(STR,POS) ;
 N I,RSLT
 S RSLT=STR
 F I=1:1:(POS-$L(STR)) S RSLT=RSLT_" "
 Q RSLT
 ;
PAD(SC,POS) ;
 N STR
 S STR=SC
 F I=1:1:POS S STR=" "_STR
 Q $E(STR,$L(SC),$L(STR))
 ;
RESP ;
 N I,STR,NUM
 S STR="||Responses |"
 I '$D(RSP) S STR=STR_"Could not create list of responses for the report|" Q
 F I=1:1:338 D
 .S NUM=RSP(I) I NUM="" S NUM="X"
 .S STR=STR_I_" "_NUM_"  "  I I#10=0 S STR=STR_"|"
 S TXT=TXT_STR
 S TXT=TXT_"||Copyright (c) 2008, 2011 by the Regents of the University of Minnesota."
 S TXT=TXT_"|All rights reserved. Distributed exclusively under license from the University"
 S TXT=TXT_"|of Minnesota by NCS Pearson, Inc."
 S TXT=TXT_"||***eop***"
 Q
ITEM ; report Item level information
 N CRIT,LEN,TAG,TS,SUI
 S CRIT="",LEN=CANTSAY
 ;
 ;if T-Score for TSARR("SUI") above 64 D
 S SUI=$P($G(TSARR("SUI")),U,3)
 I SUI>64 D
 .S TXT=TXT_"||NOTE-  The T score for the Suicidal/Death Ideation Scale (SUI) is above 64.|"
 ;
 S TXT=TXT_"||ITEM-LEVEL INFORMATION |"
 ; if no Cannot Say questions:
 I $L(CANTSAY)=0 D
 .S TXT=TXT_"|There were no unscorable responses to all the MMPI-2-RF items."
 E  S TXT=TXT_"|The ""Cannot Say"" questions are "_CANTSAY
 ;
 S TXT=TXT_"||Critical Responses |Seven MMPI-2-RF scales--Suicidal/Death Ideation (SUI), Helplessness/Hopelessness (HLP), |"
 S TXT=TXT_"Anxiety (AXY), Ideas of Persecution (RC6), Aberrant Experiences (RC8), Substance Abuse|"
 S TXT=TXT_"(SUB), and Aggression (AGG)--have been designated by the test authors as having critical|"
 S TXT=TXT_"item content that may require immediate attention and follow-up. Items answered by the|"
 S TXT=TXT_"individual in the keyed direction (True or False) on a critical scale are listed below|"
 S TXT=TXT_"if his T score on that scale is 65 or higher.||"
 ;
 F TAG="SUI","HLP","AXY","RC6","RC8","SUB","AGG" D
 .I $P(TSARR(TAG),U,3)>64 D
 ..I TAG="SUI" S CRIT=CRIT_"|Suicidal/Death Ideation (SUI, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="HLP" S CRIT=CRIT_"|Helplessness/Hopelessness (HLP, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="AXY" S CRIT=CRIT_"|Anxiety (AXY, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="RC6" S CRIT=CRIT_"|Ideas of Persecution (RC6, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="RC8" S CRIT=CRIT_"|Aberrant Experiences (RC8, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="SUB" S CRIT=CRIT_"|Substance Abuse (SUB, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..I TAG="AGG" S CRIT=CRIT_"|Aggression (AGG, T Score="_$P(TSARR(TAG),U,3)_")|"
 ..D CRITRSP(TAG)
 I $L(CRIT) S TXT=TXT_CRIT
 S TXT=TXT_"||***eop***"
 Q
 ;
CRITRSP(TAG) ;
 N J,VAL,X
 F J=1:1 S X=$P($T(@TAG+J),";;",2,99) Q:X="zzzzz"  S VAL=$P(X,U,3) I VAL=RSP($P(X,U)) D
 .S VAL=$S(VAL="T":"TRUE",VAL="F":"FALSE",1:"")
 .I $L($P(X,U))=2 S $P(X,U)=" "_$P(X,U)
 .S CRIT=CRIT_$P(X,U)_". "_$P(X,U,2)_" ("_VAL_")|"
 Q
 ;
RC8 ;
 ;;12^I often feel I can read other people's minds.^T
 ;;32^I have had very peculiar and strange experiences.^T
 ;;46^When I am with people, I am bothered by hearing very strange things.^T
 ;;85^I have never seen a vision.^F
 ;;106^I have had periods in which I carried on activities without knowing later what I had|     been doing.^T
 ;;122^I have had attacks in which I could not control my movements or speech but in which|     I knew what was going on around me.^T
 ;;139^I often hear voices without knowing where they come from.^T
 ;;159^I have had blank spells in which my activities were interrupted and I did not know|     what was going on around me.^T
 ;;179^Sometimes my voice leaves me or changes even though I have no cold.^T
 ;;199^Peculiar odors come to me at times.^T
 ;;203^My soul sometimes leaves my body.^T
 ;;216^At times I hear so well it bothers me.^T
 ;;240^I often feel as if things are not real.^T
 ;;257^I have strange and peculiar thoughts.^T
 ;;273^I hear strange things when I am alone.^T
 ;;294^I see things or animals or people around me that others do not see.^T
 ;;311^Sometimes I am sure that other people can tell what I am thinking.^T
 ;;330^I sometimes seem to hear my thoughts being spoken out loud.^T
 ;;zzzzz
RC6 ;
 ;;14^Evil spirits possess me at times.^T
 ;;34^Ghosts or spirits can influence people for good or bad.^T
 ;;71^I believe I am being plotted against.^T
 ;;92^I believe I am being followed.^T
 ;;110^I feel that I have often been punished without cause.^T
 ;;129^Someone has been trying to poison me.^T
 ;;150^Someone has been trying to rob me.^T
 ;;168^There are persons who are trying to steal my thoughts and ideas.^T
 ;;194^I am sure I am being talked about.^T
 ;;212^I have no enemies who really wish to harm me.^F
 ;;233^People say insulting and vulgar things about me.^T
 ;;252^Someone has control over my mind.^T
 ;;264^Someone has it in for me.^T
 ;;270^At one or more times in my life I felt that someone was making me do things by|     hypnotizing me.^T
 ;;287^Someone has been trying to influence my mind.^T
 ;;310^People are not very kind to me.^T
 ;;332^If people had not had it in for me, I would have been much more successful.^T
 ;;zzzzz
AGG ;
 ;;23^At times I feel like smashing things.^T
 ;;26^When people do me a wrong, I feel I should pay them back if I can, just for the|     principle of the thing.^T
 ;;41^Sometimes I enjoy hurting persons I love.^T
 ;;84^At times I feel like picking a fist fight with someone.^T
 ;;231^I can easily make other people afraid of me, and sometimes do for the fun of it.^T
 ;;312^I have gotten angry and broken furniture or dishes when I was drinking.^T
 ;;316^I have at times had to be rough with people who were rude or annoying.^T
 ;;329^I've been so angry at times that I've hurt someone in a physical fight.^T
 ;;337^I have become so angry with someone that I have felt as if I would explode.^T
 ;;zzzzz
SUB ;
 ;;49^I have enjoyed using marijuana.^T
 ;;86^I can express my (TRUE)feelings only when I drink.^T
 ;;141^I have used alcohol excessively.^T
 ;;192^After a bad day, I usually need a few drinks to relax.^T
 ;;237^Except by doctor''s orders I never take drugs or sleeping pills.^F
 ;;266^I have a drug or alcohol problem.^T
 ;;297^Once a week or more I get high or drunk.^T
 ;;zzzzz
AXY ;
 ;;79^I have nightmares every few nights.^T
 ;;146^Almost every day something happens to frighten me.^T
 ;;228^I feel anxiety about something or someone almost all the time.^T
 ;;275^Several times a week I feel as if something dreadful is about to happen.^T
 ;;289^I have often been frightened in the middle of the night.^T
 ;;zzzzz
SUI ;
 ;;93^I have recently considered killing myself.^T
 ;;120^Most of the time I wish I were dead.^T
 ;;164^Lately I have thought a lot about killing myself.^T
 ;;251^No one knows it but I have tried to kill myself.^T
 ;;334^My thoughts these days turn more and more to death and the life hereafter.^T
 ;;zzzzz
HLP ;
 ;;135^It bothers me greatly to think of making changes in my life.^T
 ;;169^The future seems hopeless to me.^T
 ;;214^Although I am not happy with my life, there is nothing I can do about it now.^T
 ;;282^My main goals in life are within my reach.^F
 ;;336^I recognize several faults in myself that I will not be able to change.^T
 ;;zzzzz
 Q
