const chapters = {
  orlando: {
    name: "Orlando Youth Alliance",
    logo: "/assets/img/OYA-horizontal-white-dropshadow-text.png",
  },
  seminole: {
    name: "Seminole Youth Alliance",
    logo: "/assets/img/SYA-horizontal.png",
  },
  lakeland: {
    name: "Lakeland Youth Alliance",
    logo: "/assets/img/LYA-horizontal.png",
  },
  osceola: {
    name: "Osceola Youth Alliance",
    logo: "/assets/img/osceolaHiRes.png",
  },
};

export default chapters[process.env.CHAPTER] ?? chapters.orlando;
