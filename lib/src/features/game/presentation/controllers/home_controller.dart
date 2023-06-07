import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentWord = StateProvider((ref) => '');
final currentIndex = StateProvider(
  (ref) => math.Random().nextInt(ref.watch(words).length - 1),
);
final words = StateProvider((ref) => [
      {
        "word": "cat",
        "hint":
            "A small, carnivorous mammal with soft fur, a short snout, and retractable claws"
      },
      {
        "word": "dog",
        "hint":
            "A domesticated carnivorous mammal with a pointed snout, a bushy tail, and keen senses"
      },
      {
        "word": "bee",
        "hint":
            "An insect with wings, a slender body, and a stinger, that collects nectar and pollen from flowers"
      },
      {
        "word": "cup",
        "hint":
            "A small, open container for drinking from, typically having a handle and a narrow neck"
      },
      {
        "word": "car",
        "hint":
            "A road vehicle with four wheels, powered by an internal combustion engine or electric motor"
      },
      {
        "word": "box",
        "hint":
            "A container with a flat base and sides, typically square or rectangular and having a lid"
      },
      {
        "word": "sun",
        "hint":
            "The star around which the Earth orbits, the source of heat and light for the solar system"
      },
      {
        "word": "key",
        "hint":
            "A small piece of shaped metal or plastic, with incisions cut to fit the wards of a particular lock, used to open or close it"
      },
      {
        "word": "fan",
        "hint":
            "A machine with blades that rotate to create a current of air, used for cooling or ventilation"
      },
      {
        "word": "pen",
        "hint":
            "A writing instrument with a nib or ballpoint that dispenses ink"
      },
      {
        "word": "cupcake",
        "hint": "A small cake baked in a paper or foil cup and typically iced"
      },
      {
        "word": "pizza",
        "hint":
            "A dish consisting of a flat, round base of dough baked with tomato sauce and cheese, typically with added meat or vegetables"
      },
      {
        "word": "juice",
        "hint": "A liquid drink made from pressed fruit or vegetables"
      },
      {
        "word": "bike",
        "hint":
            "A pedal-driven vehicle with two wheels, typically propelled by the rider's feet"
      },
      {
        "word": "boat",
        "hint":
            "A small vessel for traveling on water, propelled by oars, sails, or an engine"
      },
      {
        "word": "book",
        "hint":
            "A written or printed work consisting of pages glued or sewn together along one side and bound in covers"
      },
      {
        "word": "chair",
        "hint":
            "A separate seat for one person, typically with a back and four legs"
      },
      {
        "word": "coat",
        "hint":
            "An outer garment worn outdoors, typically having sleeves and a long length"
      },
      {
        "word": "coffee",
        "hint":
            "A hot drink made from the roasted and ground beanlike seeds of a tropical shrub"
      },
      {
        "word": "desk",
        "hint":
            "A piece of furniture with a flat or sloping surface and typically with drawers, used for writing or working at"
      },
      {
        "word": "dinner",
        "hint": "The main meal of the day, typically eaten in the evening"
      },
      {
        "word": "door",
        "hint":
            "A movable barrier used to close off an entrance, typically consisting of a flat panel that swings on hinges or slides or rotates"
      },
      {
        "word": "fork",
        "hint":
            "An implement with two or more prongs used for lifting food to the mouth or holding it when cutting"
      },
      {
        "word": "guitar",
        "hint":
            "A stringed musical instrument with a fretted fingerboard and a typically curved body"
      },
      {
        "word": "butterfly",
        "hint": "An insect with large brightly colored wings"
      },
      {"word": "canary", "hint": "A small yellow songbird"},
      {
        "word": "chemistry",
        "hint":
            "The scientific study of the composition, properties, and behavior of matter"
      },
      {
        "word": "dessert",
        "hint": "A sweet course typically eaten at the end of a meal"
      },
      {
        "word": "diamond",
        "hint":
            "A precious stone consisting of a clear and typically colorless crystalline form of pure carbon"
      },
      {
        "word": "dolphin",
        "hint":
            "A small gregarious toothed whale that typically has a beaklike snout and a curved fin on the back"
      },
      {
        "word": "frost",
        "hint":
            "A deposit of small ice crystals formed on a surface due to the freezing of water vapor"
      },
      {
        "word": "geography",
        "hint":
            "The study of the physical features of the earth and its atmosphere, and of human activity as it affects and is affected by these"
      },
      {
        "word": "giraffe",
        "hint": "A large African mammal with a very long neck and forelegs"
      },
      {
        "word": "hamster",
        "hint":
            "A small rodent with a short tail and large cheek pouches, often kept as a pet"
      },
      {
        "word": "hockey",
        "hint":
            "A game played on ice, in which two teams of skaters use sticks to shoot a small rubber puck into the opposing team's goal"
      },
      {
        "word": "jungle",
        "hint":
            "An area of land overgrown with dense forest and tangled vegetation, typically in the tropics"
      },
      {
        "word": "kiwi",
        "hint":
            "A flightless bird native to New Zealand, or a brown, fuzzy fruit with green flesh and black seeds"
      },
      {
        "word": "laptop",
        "hint": "A portable computer small enough to use on one's lap"
      },
      {"word": "lemon", "hint": "A yellow citrus fruit with a sour taste"},
      {
        "word": "library",
        "hint":
            "A building or room containing collections of books, periodicals, and sometimes films and recorded music for people to read, borrow, or refer to"
      },
      {
        "word": "mango",
        "hint": "A sweet tropical fruit with a yellowish-orange flesh"
      },
      {
        "word": "marble",
        "hint":
            "A small hard ball or sphere, typically made of glass or polished stone, used as a toy or in games"
      },
      {
        "word": "ocean",
        "hint":
            "A very large expanse of sea, in particular each of the main areas into which the sea is divided geographically"
      },
      {
        "word": "octopus",
        "hint":
            "A cephalopod mollusk with eight sucker-bearing arms, a soft sac-like body, and no internal skeleton"
      },
      {
        "word": "penguin",
        "hint":
            "A flightless bird of the southern hemisphere, typically black-and-white and living in large colonies on the Antarctic coast"
      },
      {
        "word": "piano",
        "hint":
            "A large keyboard musical instrument with a wooden case enclosing a soundboard and metal strings, which are struck by hammers when the keys are depressed"
      },
      {
        "word": "popcorn",
        "hint":
            "A variety of corn with hard kernels that swell up and burst open with a pop when heated"
      },
      {
        "word": "porcupine",
        "hint":
            "A large, heavily built rodent with sharp spines or quills on its back"
      },
      {
        "word": "apple",
        "hint":
            "A round fruit with red, yellow or green skin and a crisp white interior"
      },
      {"word": "ball", "hint": "A round object used in games and sports"},
      {
        "word": "cat",
        "hint":
            "A small domesticated carnivorous mammal with soft fur and retractable claws"
      },
      {
        "word": "dog",
        "hint":
            "A domesticated carnivorous mammal with fur, four legs, and a tail"
      },
      {
        "word": "egg",
        "hint":
            "An oval or round object laid by a female bird, reptile, or fish, containing an embryo"
      },
      {
        "word": "flower",
        "hint":
            "A brightly colored and sweet-smelling plant used as decoration or gift"
      },
      {
        "word": "grape",
        "hint":
            "A small juicy fruit with a smooth skin and usually seeded interior"
      },
      {
        "word": "hat",
        "hint": "A head covering with a brim and sometimes a peak or visor"
      },
      {
        "word": "ice",
        "hint":
            "Frozen water, a solid state of the liquid that is transparent and colorless"
      },
      {
        "word": "jacket",
        "hint":
            "A garment for the upper body, usually with sleeves and a front opening"
      },
      {
        "word": "kite",
        "hint":
            "A light frame covered with paper, cloth, or plastic, flown in the wind at the end of a long string"
      },
      {
        "word": "lemon",
        "hint":
            "A bright yellow citrus fruit with acidic juice used in cooking and drinks"
      },
      {
        "word": "map",
        "hint":
            "A diagrammatic representation of an area of land or sea showing physical features, cities, roads, etc."
      },
      {
        "word": "note",
        "hint":
            "A brief written or printed record of something, such as a reminder or explanation"
      },
      {
        "word": "orange",
        "hint":
            "A round citrus fruit with a tough bright reddish-yellow rind and sweet juicy segments inside"
      },
      {
        "word": "pizza",
        "hint":
            "A savory dish of Italian origin, consisting of a usually round, flattened base of dough baked with a topping"
      },
      {
        "word": "queen",
        "hint":
            "A female monarch, the wife or widow of a king, or a woman considered preeminent in a particular field"
      },
      {
        "word": "rain",
        "hint":
            "Precipitation in the form of water droplets falling from clouds"
      },
      {
        "word": "socks",
        "hint":
            "A covering for the foot, typically made of cotton or wool, worn inside a shoe"
      },
      {
        "word": "table",
        "hint":
            "A piece of furniture with a flat top and one or more legs, used as a surface for working at, eating from, or on which to place things"
      },
      {
        "word": "umbrella",
        "hint":
            "A collapsible canopy used as a shade or protection from rain or sun"
      },
      {
        "word": "van",
        "hint": "A large motor vehicle used for transporting goods or people"
      },
      {
        "word": "watch",
        "hint": "A small timepiece worn on a wrist or carried in a pocket"
      },
      {
        "word": "xylophone",
        "hint":
            "A musical instrument consisting of a set of wooden bars of varying lengths that are struck with mallets to produce musical tones"
      },
      {
        "word": "yacht",
        "hint":
            "A medium-sized sailing vessel with a cabin and sometimes a small motor"
      },
      {
        "word": "zebra",
        "hint": "An African mammal with black and white stripes"
      },
    ]);
