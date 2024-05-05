// import 'package:moodee/models/testimonial_model.dart';
// import 'package:moodee/models/therapists_model.dart';

// List<Therapist> therapistList = [
//   Therapist(
//       id: '',
//       name: "Sheryl",
//       image: "lib/assets/images/therapist1.png",
//       title: "Therapist",
//       rating: "4.9",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist1bg.png",
//       experience: "10 years",
//       workplace: "Calm Minds Therapy Clinic",
//       aboutThisTherapist:
//           "I'm Dr. Sheryl, a compassionate and dedicated Licensed Clinical Therapist with over 10 years of experience in providing therapy and mental health support to individuals, couples, and families. My approach to therapy is client-centered, collaborative, and holistic, focusing on empowering individuals to overcome challenges, improve their well-being, and live fulfilling lives.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Trauma and Abuse',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Moon.png',
//           'text': 'Sleeping Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Bipolar Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/meditation.png',
//           'text': 'Meditation',
//         },
//       ],
//       availability: [
//         "10 May 2024, 9AM",
//         "10 May 2024, 11AM",
//         "10 May 2024, 1PM",
//         "11 May 2024, 9AM",
//         "11 May 2024, 11AM",
//         "11 May 2024, 1PM",
//         "12 May 2024, 9AM",
//         "12 May 2024, 11AM",
//         "12 May 2024, 1PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "r7C227JXDKaSU2FtuKX0tv9QGs42",
//           rating: 4.9,
//           testimonialText:
//               """Embarking on the therapeutic journey with Sheryl has been nothing short of life-changing. Their unwavering dedication to my well-being, coupled with a profound understanding of human psychology, has provided me with invaluable insights and tools to navigate life's challenges with newfound strength and clarity.
// From the very first session, I felt seen, heard, and understood in ways I never thought possible. Sheryl’s empathetic approach and genuine commitment to my growth have created a safe and nurturing space where I can explore my deepest thoughts and emotions without fear of judgment.
// """,
//         ),
//         Testimonial(
//           uid: "ohCcH2dp6tNlJXuMGunzTqj2SyN2",
//           rating: 5.0,
//           testimonialText:
//               "Through Sheryl's expert guidance, I've gained a deeper understanding of myself, developed healthier coping mechanisms, and forged a path towards healing and self-acceptance.",
//         ),
//       ]),
//   Therapist(
//       id: '',
//       name: "John",
//       image: "lib/assets/images/therapist2.png",
//       title: "Counselor",
//       rating: "4.8",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist2bg.png",
//       experience: "15 years",
//       workplace: "Mindful Wellness Institute",
//       aboutThisTherapist:
//           "I am an empathetic and skilled Licensed Professional Counselor with over 15 years of experience in individual therapy. Grounded in psychodynamic theory and mindfulness practices, I provide a supportive environment for clients to explore their inner world, heal past wounds, and build a foundation for a more fulfilling life.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Family Therapy',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Moon.png',
//           'text': 'Sleeping Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Anxiety Management',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/meditation.png',
//           'text': 'Meditation',
//         },
//       ],
//       availability: [
//         "10 May 2024, 2PM",
//         "10 May 2024, 3PM",
//         "10 May 2024, 4PM",
//         "11 May 2024, 2PM",
//         "11 May 2024, 3PM",
//         "11 May 2024, 4PM",
//         "12 May 2024, 2PM",
//         "12 May 2024, 3PM",
//         "12 May 2024, 4PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "iBTXcNbyzjetNDXyvEgNtEcNuhg1",
//           rating: 5.0,
//           testimonialText:
//               "John is a dedicated therapist whose empathy and understanding have been invaluable to me. He listens attentively and offers insightful perspectives that have helped me gain clarity and confidence in my decisions. His genuine care for his clients shines through in every session, making him a trusted ally in my journey towards self-discovery and healing.",
//         ),
//         Testimonial(
//           uid: "jGHRtG4Tsgf6BE7N9ZzvN93TRJw1",
//           rating: 5.0,
//           testimonialText:
//               "I cannot speak highly enough of John's expertise and professionalism. From our very first session, he demonstrated a deep understanding of my concerns and provided practical strategies to address them. His calm demeanor and genuine interest in my well-being have made therapy a positive and empowering experience. I am grateful to have John as my therapist, guiding me towards a happier and healthier life.",
//         ),
//       ]),
//   Therapist(
//       id: '',
//       name: "Monica",
//       image: "lib/assets/images/therapist3.png",
//       title: "Social Worker",
//       rating: "4.8",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist3bg.png",
//       experience: "6 years",
//       workplace: "Zen Path Therapy Center",
//       aboutThisTherapist:
//           "I am a seasoned and insightful Licensed Clinical Social Worker with a passion for empowering individuals to overcome adversity. With expertise in trauma-informed care and narrative therapy, I help clients rewrite their stories, reclaim their agency, and create a future filled with hope and possibility.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Trauma and Abuse',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/eatingdisorder.png',
//           'text': 'Eating Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Stress Management',
//         },
//         {
//           'image':
//               'lib/assets/images/claudias-part_branch/personalitydisorder.png',
//           'text': 'Personality Disorders',
//         },
//       ],
//       availability: [
//         "10 May 2024, 5PM",
//         "10 May 2024, 6PM",
//         "10 May 2024, 7PM",
//         "11 May 2024, 5PM",
//         "11 May 2024, 6PM",
//         "11 May 2024, 7PM",
//         "12 May 2024, 5PM",
//         "12 May 2024, 6PM",
//         "12 May 2024, 7PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "44GxUdk3CWbn93iUc9AXFw6xbj13",
//           rating: 4.9,
//           testimonialText:
//               "Monica is an exceptional therapist who creates a warm and supportive environment for her clients. Her intuitive approach and genuine compassion have helped me navigate through challenging times with grace and resilience. She offers valuable insights and practical tools that have empowered me to overcome obstacles and thrive. I am grateful for Monica's guidance and highly recommend her to anyone seeking transformational therapy.",
//         ),
//         Testimonial(
//           uid: "KheD9t5DG2QqGAYv4LEoevt51ta2",
//           rating: 4.7,
//           testimonialText:
//               "Monica's guidance has been instrumental in my personal growth journey. Her ability to listen without judgment and offer thoughtful perspectives has allowed me to explore deep-seated issues with honesty and courage. Through her guidance, I've gained invaluable insights into myself and developed healthier coping mechanisms. Monica's genuine care and expertise make her an invaluable asset to anyone seeking support and guidance in their mental health journey.",
//         ),
//       ]),
//   Therapist(
//       id: '',
//       name: "Eric",
//       image: "lib/assets/images/therapist4.png",
//       title: "Psychologist",
//       rating: "4.6",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist4bg.png",
//       experience: "10 years",
//       workplace: "Serenity Springs Counseling",
//       aboutThisTherapist:
//           "Hi, I am a compassionate and dedicated Clinical Psychologist with a wealth of experience spanning over 10 years. Specializing in cognitive-behavioral therapy and solution-focused approaches, I collaborate with clients to navigate life's challenges and cultivate resilience, fostering positive change and personal growth.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Trauma and Abuse',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Moon.png',
//           'text': 'Sleeping Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Stress Management',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/meditation.png',
//           'text': 'Meditation',
//         },
//       ],
//       availability: [
//         "10 May 2024, 8PM",
//         "10 May 2024, 9PM",
//         "10 May 2024, 10PM",
//         "11 May 2024, 8PM",
//         "11 May 2024, 9PM",
//         "11 May 2024, 10PM",
//         "12 May 2024, 8PM",
//         "12 May 2024, 9PM",
//         "12 May 2024, 10PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "1vU1zqQc7rdKn5BonECnomokl053",
//           rating: 4.8,
//           testimonialText:
//               "Eric is a compassionate and skilled therapist who goes above and beyond to support his clients. His empathetic nature and non-judgmental approach create a safe space where I feel comfortable expressing myself openly. Eric's insights and guidance have helped me gain a deeper understanding of myself and develop effective strategies for managing stress and anxiety. I highly recommend Eric to anyone seeking transformative therapy.",
//         ),
//         Testimonial(
//           uid: "h0d5fqDDvxTsAlIE1OVWbU0blNj1",
//           rating: 5.0,
//           testimonialText:
//               "I am incredibly grateful for Eric's guidance and support throughout my therapy journey. His patience, empathy, and expertise have empowered me to confront my challenges with courage and resilience. Eric's holistic approach addresses both the emotional and practical aspects of my concerns, providing me with valuable tools for personal growth and self-improvement. I wholeheartedly recommend Eric to anyone seeking a compassionate and skilled therapist.",
//         ),
//       ]),
//   Therapist(
//       id: '',
//       name: "Lee",
//       image: "lib/assets/images/claudias-part_branch/therapist5.png",
//       title: "Psychologist",
//       rating: "4.8",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist5bg.png",
//       experience: "12 years",
//       workplace: "Serenity Springs Counseling",
//       aboutThisTherapist:
//           "With over a decade of expertise, I stand as a beacon of empathy and commitment in the realm of Clinical Psychology. My adeptness in cognitive-behavioral therapy and solution-focused methods empowers clients to confront adversities, fostering resilience and instigating transformative journeys toward growth.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Trauma and Abuse',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Moon.png',
//           'text': 'Sleeping Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Stress Management',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/meditation.png',
//           'text': 'Meditation',
//         },
//       ],
//       availability: [
//         "12 May 2024, 8PM",
//         "12 May 2024, 9PM",
//         "12 May 2024, 10PM",
//         "13 May 2024, 8PM",
//         "13 May 2024, 9PM",
//         "13 May 2024, 10PM",
//         "14 May 2024, 8PM",
//         "14 May 2024, 9PM",
//         "14 May 2024, 10PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "KsuIZjP7w1ZaOzzNK8udUAmeMSl1",
//           rating: 5.0,
//           testimonialText:
//               "Lee is a phenomenal therapist whose expertise and compassion have made a profound impact on my life. From our initial sessions, I felt understood and supported in a way I never have before. Lee's insightful observations and gentle guidance have helped me navigate through complex emotions and patterns, leading to profound personal growth and healing. I am incredibly grateful for Lee's presence on my journey towards wholeness.",
//         ),
//         Testimonial(
//           uid: "fd2buIMH51WQb2qSIfjgpugXoJj1",
//           rating: 5.0,
//           testimonialText:
//               "I cannot thank Lee enough for the positive changes I've experienced since starting therapy with them. Their unwavering support, empathy, and expertise have helped me overcome obstacles and develop a deeper sense of self-awareness and resilience. Lee creates a nurturing and non-judgmental space where I feel safe exploring my thoughts and emotions. Their guidance has been invaluable in my journey towards greater self-acceptance and fulfillment.",
//         ),
//       ]),
//   Therapist(
//       id: '',
//       name: "Alicia",
//       image: "lib/assets/images/claudias-part_branch/therapist6.png",
//       title: "Psychologist",
//       rating: "5.0",
//       imageCard: "lib/assets/images/claudias-part_branch/therapist6bg.png",
//       experience: "10 years",
//       workplace: "Mindful Wellness Institute",
//       aboutThisTherapist:
//           "Embodying a decade-long journey of compassion and unwavering dedication, I emerge as a stalwart figure in Clinical Psychology. Through my mastery of cognitive-behavioral therapy and solution-oriented strategies, I embark on collaborative endeavors with clients, nurturing resilience and steering them towards profound personal evolution.",
//       areaOfExpertise: [
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Heart.png',
//           'text': 'Family Therapy',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/Moon.png',
//           'text': 'Sleeping Disorder',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/bipolar.png',
//           'text': 'Anxiety Management',
//         },
//         {
//           'image': 'lib/assets/images/claudias-part_branch/meditation.png',
//           'text': 'Meditation',
//         },
//       ],
//       availability: [
//         "20 May 2024, 8PM",
//         "20 May 2024, 9PM",
//         "20 May 2024, 10PM",
//         "21 May 2024, 8PM",
//         "21 May 2024, 9PM",
//         "21 May 2024, 10PM",
//         "22 May 2024, 8PM",
//         "22 May 2024, 9PM",
//         "22 May 2024, 10PM",
//       ],
//       testimonial: [
//         Testimonial(
//           uid: "UxJekdmRgagY2LkdpXeKMHVRcJM2",
//           rating: 4.9,
//           testimonialText:
//               "Alicia is an extraordinary therapist whose compassion and insight have guided me through some of the darkest times in my life. Her genuine care and empathy create a supportive environment where I feel heard and understood. Alicia's expertise in various therapeutic modalities has equipped me with the tools to navigate through challenges and cultivate a greater sense of self-awareness and empowerment. I am deeply grateful for Alicia's presence in my life.",
//         ),
//         Testimonial(
//           uid: "HiJfOQyX4wONT8TdpTDValRJKjk1",
//           rating: 5.0,
//           testimonialText:
//               "Alicia is a true beacon of light in the world of therapy. Her warmth, empathy, and expertise have been instrumental in my healing journey. From our first session, Alicia's ability to deeply listen and offer meaningful insights helped me gain clarity and perspective on my life. With her guidance, I've learned to navigate through difficult emotions and develop healthier coping mechanisms. I highly recommend Alicia to anyone seeking compassionate and transformative therapy.",
//         ),
//       ]),
// ];
