import 'package:moodee/models/therapists_model.dart';

List<Therapist> therapistList = [
  Therapist(
    name: "Sheryl",
    image: "lib/assets/images/therapist1.png",
    title: "Therapist",
    rating: "4.9",
    imageCard: "lib/assets/images/claudias-part_branch/therapist1bg.png",
    experience: "10 years",
    workplace: "Calm Minds Therapy Clinic",
    aboutThisTherapist:
        "I'm Dr. Sheryl, a compassionate and dedicated Licensed Clinical Therapist with over 10 years of experience in providing therapy and mental health support to individuals, couples, and families. My approach to therapy is client-centered, collaborative, and holistic, focusing on empowering individuals to overcome challenges, improve their well-being, and live fulfilling lives.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Trauma and Abuse',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/Moon.png',
        'text': 'Sleeping Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Bipolar Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/meditation.png',
        'text': 'Meditation',
      },
    ],
    availability: [
      "10 May 2024, 9AM",
      "10 May 2024, 11AM",
      "10 May 2024, 1PM",
      "11 May 2024, 9AM",
      "11 May 2024, 11AM",
      "11 May 2024, 1PM",
      "12 May 2024, 9AM",
      "12 May 2024, 11AM",
      "12 May 2024, 1PM",
    ],
  ),
  Therapist(
    name: "John",
    image: "lib/assets/images/therapist2.png",
    title: "Counselor",
    rating: "4.8",
    imageCard: "lib/assets/images/claudias-part_branch/therapist2bg.png",
    experience: "15 years",
    workplace: "Mindful Wellness Institute",
    aboutThisTherapist:
        "I am an empathetic and skilled Licensed Professional Counselor with over 15 years of experience in individual therapy. Grounded in psychodynamic theory and mindfulness practices, I provide a supportive environment for clients to explore their inner world, heal past wounds, and build a foundation for a more fulfilling life.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Family Therapy',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/Moon.png',
        'text': 'Sleeping Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Anxiety Management',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/meditation.png',
        'text': 'Meditation',
      },
    ],
    availability: [
      "10 May 2024, 2PM",
      "10 May 2024, 3PM",
      "10 May 2024, 4PM",
      "11 May 2024, 2PM",
      "11 May 2024, 3PM",
      "11 May 2024, 4PM",
      "12 May 2024, 2PM",
      "12 May 2024, 3PM",
      "12 May 2024, 4PM",
    ],
  ),
  Therapist(
    name: "Monica",
    image: "lib/assets/images/therapist3.png",
    title: "Social Worker",
    rating: "4.8",
    imageCard: "lib/assets/images/claudias-part_branch/therapist3bg.png",
    experience: "6 years",
    workplace: "Zen Path Therapy Center",
    aboutThisTherapist:
        "I am a seasoned and insightful Licensed Clinical Social Worker with a passion for empowering individuals to overcome adversity. With expertise in trauma-informed care and narrative therapy, I help clients rewrite their stories, reclaim their agency, and create a future filled with hope and possibility.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Trauma and Abuse',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/eatingdisorder.png',
        'text': 'Eating Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Stress Management',
      },
      {
        'image':
            'lib/assets/images/claudias-part_branch/personalitydisorder.png',
        'text': 'Personality Disorders',
      },
    ],
    availability: [
      "10 May 2024, 5PM",
      "10 May 2024, 6PM",
      "10 May 2024, 7PM",
      "11 May 2024, 5PM",
      "11 May 2024, 6PM",
      "11 May 2024, 7PM",
      "12 May 2024, 5PM",
      "12 May 2024, 6PM",
      "12 May 2024, 7PM",
    ],
  ),
  Therapist(
    name: "Eric",
    image: "lib/assets/images/therapist4.png",
    title: "Psychologist",
    rating: "4.6",
    imageCard: "lib/assets/images/claudias-part_branch/therapist4bg.png",
    experience: "10 years",
    workplace: "Serenity Springs Counseling",
    aboutThisTherapist:
        "Hi, I am a compassionate and dedicated Clinical Psychologist with a wealth of experience spanning over 10 years. Specializing in cognitive-behavioral therapy and solution-focused approaches, I collaborate with clients to navigate life's challenges and cultivate resilience, fostering positive change and personal growth.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Trauma and Abuse',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/Moon.png',
        'text': 'Sleeping Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Stress Management',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/meditation.png',
        'text': 'Meditation',
      },
    ],
    availability: [
      "10 May 2024, 8PM",
      "10 May 2024, 9PM",
      "10 May 2024, 10PM",
      "11 May 2024, 8PM",
      "11 May 2024, 9PM",
      "11 May 2024, 10PM",
      "12 May 2024, 8PM",
      "12 May 2024, 9PM",
      "12 May 2024, 10PM",
    ],
  ),
  Therapist(
    name: "Lee",
    image: "lib/assets/images/claudias-part_branch/therapist5.png",
    title: "Psychologist",
    rating: "4.8",
    imageCard: "lib/assets/images/claudias-part_branch/therapist5bg.png",
    experience: "12 years",
    workplace: "Serenity Springs Counseling",
    aboutThisTherapist:
        "With over a decade of expertise, I stand as a beacon of empathy and commitment in the realm of Clinical Psychology. My adeptness in cognitive-behavioral therapy and solution-focused methods empowers clients to confront adversities, fostering resilience and instigating transformative journeys toward growth.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Trauma and Abuse',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/Moon.png',
        'text': 'Sleeping Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Stress Management',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/meditation.png',
        'text': 'Meditation',
      },
    ],
    availability: [
      "12 May 2024, 8PM",
      "12 May 2024, 9PM",
      "12 May 2024, 10PM",
      "13 May 2024, 8PM",
      "13 May 2024, 9PM",
      "13 May 2024, 10PM",
      "14 May 2024, 8PM",
      "14 May 2024, 9PM",
      "14 May 2024, 10PM",
    ],
  ),
  Therapist(
    name: "Alicia",
    image: "lib/assets/images/claudias-part_branch/therapist6.png",
    title: "Psychologist",
    rating: "5.0",
    imageCard: "lib/assets/images/claudias-part_branch/therapist6bg.png",
    experience: "10 years",
    workplace: "Mindful Wellness Institute",
    aboutThisTherapist:
        "Embodying a decade-long journey of compassion and unwavering dedication, I emerge as a stalwart figure in Clinical Psychology. Through my mastery of cognitive-behavioral therapy and solution-oriented strategies, I embark on collaborative endeavors with clients, nurturing resilience and steering them towards profound personal evolution.",
    areaOfExpertise: [
      {
        'image': 'lib/assets/images/claudias-part_branch/Heart.png',
        'text': 'Family Therapy',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/Moon.png',
        'text': 'Sleeping Disorder',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
        'text': 'Anxiety Management',
      },
      {
        'image': 'lib/assets/images/claudias-part_branch/meditation.png',
        'text': 'Meditation',
      },
    ],
    availability: [
      "20 May 2024, 8PM",
      "20 May 2024, 9PM",
      "20 May 2024, 10PM",
      "21 May 2024, 8PM",
      "21 May 2024, 9PM",
      "21 May 2024, 10PM",
      "22 May 2024, 8PM",
      "22 May 2024, 9PM",
      "22 May 2024, 10PM",
    ],
  ),
];
