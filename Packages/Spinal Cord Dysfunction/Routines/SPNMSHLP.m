SPNMSHLP ;WDE/SD PRINT MS DESCRIPTIONS;04/18/2000
 ;;2.0;Spinal Cord Dysfunction;**12,13**;01/02/1997
 ;;
EN1 ; Main Entry Point
 S SPNPAGE=1
 S SPNLEXIT=0
 W !!,"Display expanded Multiple Sclerosis descriptions",!
 S ZTSAVE("SPN*")=""
 D DEVICE^SPNPRTMT("PRINT^SPNMSHLP","Print MS Descriptions",.ZTSAVE) Q:SPNLEXIT
 I SPNIO="Q" D EXIT Q  ; Print was Queued
 I IO'="" D PRINT D EXIT Q  ; Print was not Queued
 Q
EXIT ; Exit routine 
 K SPNPAGE,SPNEXIT,ZTSAVE,SPN,DIR,Y
 Q
PRINT ; Print main Body
 U IO
 S Y=DT X ^DD("DD") S SPNDATE=Y
 D HEAD
 F SPN=1:1:1000 Q:$T(TEXT+SPN)=""  D  Q:SPNLEXIT=1
 .I $Y>(IOSL-5) D HEAD
 .W !,$P($T(TEXT+SPN),";;",2)
 I $E(IOST,1)="C" I SPNLEXIT=0 N DIR S DIR(0)="E" D ^DIR  K Y
 D CLOSE^SPNPRTMT
 Q
HEAD ; Header Print
 I SPNPAGE'=1 Q:$Y<(IOSL-4)
 I $E(IOST,1)="P" I SPNPAGE'=1 W #
 I $E(IOST,1)="C" D  Q:SPNLEXIT
 .I SPNPAGE=1 W @IOF Q
 .I SPNPAGE'=1 D  Q:SPNLEXIT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S SPNLEXIT=1,SPN=1000
 ..K Y
 ..W @IOF
 ..Q
 .Q
 Q:SPNLEXIT
 W !?10,"MS Expanded Help Text"
 W ?50,"Page: ",SPNPAGE,"   ",SPNDATE
 W !,$$REPEAT^XLFSTR("-",79)
 S SPNPAGE=SPNPAGE+1
 I $D(ZTQUEUED) S:$$STPCK^SPNPRTMT SPNLEXIT=1
 Q:SPNLEXIT
 Q
TEXT ;
 ;;   PYRAMIDAL
 ;;   =========
 ;;Normal
 ;;Abnormal Signs without disability.
 ;;Minimal disability.
 ;;Mild to moderate paraparesis or hemiparesis; severe monoparesis.
 ;;Marked paraparesis or hemiparesis; moderate quadriparesis, or 
 ;;   monoplegia.
 ;;Paraplegia, hemiplegia, or marked quadriparesis.
 ;;Quadriplegia.
 ;;Unknown
 ;;
 ;;   BRAINSTEM
 ;;   =========
 ;;Normal
 ;;Signs only.
 ;;Moderate nystagmus or other mild disability.
 ;;Severe nystagmus, marked extraocular weakness.
 ;;Marked dysarthria.
 ;;Inability to swallow or speak.
 ;;Unknown
 ;;
 ;;   SENSORY
 ;;   =======
 ;;Normal
 ;;Vibration or finger-writing decrease only, in 1 or 2 limbs.
 ;;Mild decrease in touch or pain or position sense, and/or 
 ;;   moderate decrease in vibration in 1 or 2 limbs or vibration
 ;;   decrease alone in 3 or 4 limbs.
 ;;Moderate decrease in touch or pain or position sense, and/or 
 ;;   essentially lost vibration in 1 or 2 limbs; mild decrease in
 ;;   touch or pain and/or moderate decrease in all proprioceptive
 ;;   tests in 3 or 4 limbs.
 ;;Marked decrease in touch or pain or loss of proprioception, alone
 ;;   or combined, in 1 or 2 limbs; or moderate decrease in touch or
 ;;   pain and/or severe proprioception decrease in more than 2 limbs.
 ;;Sensation essentially lost below head.
 ;;Unknown
 ;;
 ;;   CEREBRAL
 ;;   ========
 ;;Normal
 ;;Mood alteration only.
 ;;Mild decrease in mentation.
 ;;Moderate decrease in mentation.
 ;;Marked decrease in mentation.
 ;;Dementia or chronic brain syndrome.
 ;;Unknown
 ;;
 ;;   CEREBELLAR
 ;;   ==========
 ;;Normal
 ;;Abnormal signs without disability.
 ;;Mild ataxia.
 ;;Moderate truncal or limb ataxia (tremor or clumsy movements
 ;;   interfere with function in all spheres).
 ;;Severe ataxia in all limbs (most function is very difficult).
 ;;Unable to perform coordinated movements due to ataxia.
 ;;Weakness (grade 3 or more on pyramidal) interferes with testing.
 ;;Unknown
 ;;
 ;;   BOWEL & BLADDER
 ;;   =============== 
 ;;Normal
 ;;Mild hesitancy.
 ;;Moderate hesitance, urgency, retention or rare incontinence
 ;;   (intermittent self-catheterization, manual compression to
 ;;   evacuate bladder or finger evacuation of stool).
 ;;Frequent urinary incontinence.
 ;;In need of almost constant catheterization (and constant use of
 ;;    measure to evacuate stool).
 ;;Loss of bladder function.
 ;;Loss of bladder and bowel function.
 ;;Unknown
 ;;    
 ;;   VISUAL
 ;;   ======
 ;;Normal
 ;;Scotoma with visual acuity (corrected) better than 20/30.
 ;;Worse eye with scotoma with maximum visual acuity (corrected) or
 ;;   20/30 to 20/59.
 ;;Worse eye with large scotoma, or moderate decrease in fields, but
 ;;   with maximal visual acuity of 20/60 to 20/99.
 ;;Worse eye with marked decrease of fields and maximal visual acuity
 ;;   (corrected) of 20/100 to 20/200; grade 3 plus maximal acuity
 ;;   better eye 20/60 or less.
 ;;Worse eye with  maximal visual acuity or (corrected) less than
 ;;   20/20; grade 4 plus maximal acuity of better eye 20/60 or less.
 ;;Grade 5 plus maximal visual acuity of better eye 20/60 or less.
 ;;Presence of temporal pallor.
 ;;Unknown
 ;;
 ;;   OTHER
 ;;   =====
 ;;None
 ;;Any other neurological finding attributed to MS.
 ;;Unknown
 ;;
 ;;   EDSS
 ;;   ====
 ;;Normal neurological exam.
 ;;No disability, minimal signs in one FS.
 ;;No disability, minimal signs in more than one FS.
 ;;Minimal disability in one FS.
 ;;Minimal disability on two FS.
 ;;Moderate disability in one FS.
 ;;Fully ambulatory but with moderate disability in one FS and one
 ;;   or two FSs grade 2; or two FSs grade 3; or five FSs grade 2.
 ;;Fully ambulatory without aid, self-sufficient, up and about some
 ;;   12 hrs despite relatively severe disability consisting of one FS
 ;;   grade 4, or combinations of lesser grades exceeding limits of
 ;;   previous steps.
 ;;Fully ambulatory without aid up and about much of the day, able to
 ;;   work full day may otherwise have some limitations of full activity
 ;;   or require minimal assistance.
 ;;Ambulatory without aid or rest for about 200 meters, disability severe
 ;;   enough to impair full daily activity.
 ;;Ambulatory without aid or rest for about 100 meters, disability severe
 ;;   enough to preclude full daily activity.
 ;;Intermittent or unilateral constraint assistance (cane, crutch, brace)
 ;;   required to walk about 100 meters with or without resting.
 ;;Constant bilateral assistant (cane, crutches, brace) required to walk 
 ;;   about 20 meters without resting.
 ;;Unable to walk beyond about 5 meters even with aid; essentially
 ;;   restricted to wheelchair, wheels self in standard wheelchair and
 ;;   transfers alone; up and about in wheelchair some 12 hours a day.
 ;;Unable to take more than a few steps; restricted to wheelchair; may
 ;;   need aid in transfer; wheels self, but cannot carry on in standard
 ;;   wheelchair a full day; may require motorized wheelchair.
 ;;Essentially restricted to bed or chair or perambulated in wheelchair,
 ;;   but may be out of bed himself/herself much of the day; retains
 ;;   many self-care functions; generally has effective use of arms.
 ;;Essentially restricted to bed much of the day; has some effective use
 ;;   of arms; retains some self-care functions.
 ;;Helpless bed patient; can communicate and eat.
 ;;Totally helpless bed patient; unable to communicate effectively or
 ;;   eat/swallow.
 ;;Death due to MS
