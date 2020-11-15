
class Job {

  String position;
  String company;
  String price;
  String concept;
  String logo;
  String city;

  Job(this.position, this.company, this.price, this.concept, this.logo, this.city);

}

List<Job> getJobs(){
  return <Job>[
    Job("Flutter UI/UX", "Nike Inc.", "40", "Full-Time", "assets/images/c0.jpg", "San Francisco, California"),
    Job("Product Designer", "Google LLC", "60", "Part-Time", "assets/images/c1.jpg", "San Francisco, California"),
    Job("UI / UX Designer", "Uber Technologies Inc.", "55", "Full-Time", "assets/images/c3.jpg", "San Francisco, California"),
    Job("Lead UI/UX Designer", "Apple Inc.", "80", "Part-Time", "assets/images/p2.jpg", "San Francisco, California"),
    Job("Flutter Developer", "Amazon Inc.", "60", "Full-Time", "assets/images/p7.jpg", "San Francisco, California"),
  ];
}

List<String> getJobsRequirements(){
  return <String>[
    "Exceptional communication skills and team-working skills",
    "Know the principles of animation and you can create high fidelity prototypes",
    "Direct experience using Adobe Premiere, Adobe After Effects & other tools used to create videos, animations, etc.",
    "Good UI/UX knowledge",
  ];
}