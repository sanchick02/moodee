import 'package:moodee/models/mood_types_model.dart';

List<MoodTypeModel> moodTypeList = [
  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/happy_emoji.png', 
    question: ['What are three things that made you smile today?', 
    'What accomplishment are you most proud of recently?',
    'Who is someone you''re grateful to have in your life, and why?'], 
    type: 'Happy'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/loved_emoji.png', 
    question: ['Who is someone you cherish deeply, and why?',
    'What''s a favorite memory you have with someone you love?',
    'How can you express your appreciation for the people who mean the most to you today?',
    ], 
    type: 'Loved'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/excited_emoji.png', 
    question: ['What''s got you feeling so enthusiastic or thrilled right now?',
    'Is there an upcoming event or project you''re eagerly looking forward to?'
    'How can you channel your excitement into positive action or creativity?',
    ], 
    type: 'Excited'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/neutral_emoji.png', 
    question: ['What''s been on your mind lately that might be affecting your emotions?',
    'Is there a self-care activity or hobby you enjoy that could help lift your spirits?'
    'Would you like to explore ways to reconnect with your emotions or find meaning in your experiences?'
    ], 
    type: 'Emotionless'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/sad_emoji.png', 
    question: ['Is there a specific event or memory you''d like to share or reflect on?',
    'Would you like to talk about what''s been weighing on your mind lately?',
    'What''s one small thing that could bring a bit of brightness to your day?',
    ], 
    type: 'Sad'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/tired_emoji.png', 
    question: ['Is there a specific event or memory you''d like to share or reflect on?',
    'Would you like to talk about what''s been weighing on your mind lately?',
    'What''s one small thing that could bring a bit of brightness to your day?'], 
    type: 'Tired'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/disgust_emoji.png', 
    question: ['What''s causing you to feel repulsed or disgusted, and how can you distance yourself from it?',
    'Is there a positive or uplifting experience you can focus on to counteract those feelings?',
    'Would you like to explore ways to set boundaries and protect your well-being?',
    ], 
    type: 'Disgusted'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/anxious_emoji.png', 
    question: ['What''s been triggering your anxiety, and how can you address or manage those triggers?',
    'Is there a grounding exercise or mindfulness practice that could help calm your nerves?',
    'Would you like to talk through your worries and brainstorm coping strategies?',
    ], 
    type: 'Anxious'),

  MoodTypeModel(
    image: 'lib/assets/images/mood_tracker/angry_emoji.png', 
    question: ['What triggered your anger, and how can you address or cope with it constructively?'
    'Is there a physical activity or relaxation technique that could help release some of that tension?'
    'Would you like to explore the root cause of your anger and brainstorm healthier responses?',
    ], 
    type: 'Angry'),
];