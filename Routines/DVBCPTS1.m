DVBCPTS1 ;ALB ISC/THM-ATTACHMENT A FOR POST TRAUMATIC STRESS DISORDER ; 12/27/90  1:06 PM
 ;;2.7;AMIE;;Apr 10, 1995
EN S PG=0,DVBAX="Attachment A for Post-Traumatic Stress Disorder" W @IOF,!?(IOM-$L(DVBAX)\2),DVBAX,! S DVBAX="DSM-III-R Diagnostic Criteria for PTSD" W ?(IOM-$L(DVBAX)\2),DVBAX,!!!
 F I=0:1 S LY=$T(TXT+I) Q:LY["END"  W $P(LY,";;",2),!
 D EN1 G Q
 ;
EN1 F I=0:1 S LY=$T(SECTB+I) Q:LY["END"!(LY="")  W $P(LY,";;",2),! I $Y>55 D HD2^DVBCPTCK
Q K I,LY,DVBAX Q
 ;
TXT ;;A. The veteran has experienced an event that is outside the range of usual
 ;;human experience and that would be markedly distressing to almost anyone,
 ;;e.g., serious threat to one's life or physical integrity; serious threat
 ;;to one's children, spouse, or other close relatives and friends; sudden
 ;;destruction of one's home or community; seeing another person who has
 ;;recently been or being, seriously injured or killed as the result of an
 ;;accident or physical violence.
 ;;END
 ;;
SECTB ;;
 ;;B. The traumatic event is persistently re-experienced in at least one of the
 ;;   following ways:
 ;;
 ;;
 ;;    1. recurrent and intrusive distressing recollections of the event
 ;;
 ;;    2. recurrent distressing dreams of the event
 ;;
 ;;    3. sudden acting or feeling as if the traumatic event were recurring
 ;;       (includes a sense of reliving the experience, illusions, hallucinations
 ;;       and dissociative [flashback] episodes, even those that occur upon waking
 ;;       or when intoxicated)
 ;;
 ;;    4. intense psychological distress at exposure to events that symbolize or
 ;;       resemble an aspect of the traumatic event, including anniversaries of
 ;;       the trauma.
 ;;
 ;;C.  Persistent avoidance of stimuli associated with the trauma or numbing of
 ;;    general responsiveness (not present before the trauma), as indicated by
 ;;    at least three of the following:
 ;;
 ;;
 ;;    1. efforts to avoid thoughts or feelings associated with the trauma
 ;;
 ;;    2. efforts to avoid activities or situations that arouse recollections
 ;;       of the trauma
 ;;
 ;;    3. inability to recall an important aspect of the trauma (psychogenic
 ;;       amnesia)
 ;;
 ;;    4. markedly diminished interest in significant activities
 ;;
 ;;    5. feeling of detachment or estrangement from others
 ;;
 ;;    6. restricted range of affect, e.g., unable to have love feelings
 ;;
 ;;    7. sense of a foreshortened future, e.g., does not expect to hava a
 ;;       career, marriage, or children or a long life.
 ;;
 ;;
 ;;
 ;;
 ;;D.  Persistent symptoms of increased arousal (not present before the trauma),
 ;;    as indicated by at least two of the following:
 ;;
 ;;
 ;;    1. difficulty falling or staying asleep
 ;;
 ;;    2. irritability or outbursts of anger
 ;;
 ;;    3. difficulty concentrating
 ;;
 ;;    4. hypervigilance
 ;;
 ;;    5. exaggerated startle response
 ;;
 ;;    6. physiologic reactivity upon exposure to events that symbolize or
 ;;       resemble an aspect of the traumatic event (e.g., a woman who was
 ;;       raped in an elevator breaks out in a sweat when entering any elevator)
 ;;END
