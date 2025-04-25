import SwiftUI

struct ContentView: View {
    @State private var gender: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmi: Double?
    @State private var healthStatus: String = ""
    @State private var resultColor: Color = .black
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                Image(systemName:"heart.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.pink)
                    .padding(.top, 40)
                
                HStack{
                    Image(systemName: "person")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    TextField("Gender", text: $gender)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                HStack {
                    Image(systemName: "scalemass")
                        .foregroundColor(.blue)
                    TextField("Enter weight (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
        
                HStack {
                    Image(systemName: "ruler")
                        .foregroundColor(.blue)
                    TextField("Enter height (cm)", text: $height)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                }
                Button("Calculate BMI") {
                    calculateBMI()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                if let bmi = bmi {
                    VStack(spacing: 10) {
                        Text(String(format: "Your BMI: %.1f", bmi))
                            .font(.title)
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(resultColor.opacity(0.2))
                    .cornerRadius(12)
                }
                
            }
            Spacer()
            .padding()
            .navigationTitle("BMI Calculator")
        }
    }
    func calculateBMI() {
        guard let weightValue = Double(weight),
              let heightValue = Double(height),
              heightValue > 0 else {
            bmi = nil
            healthStatus = "Invalid input"
            resultColor = .red
            return
        }
        
        let heightInMeters = heightValue / 100
        let bmiValue = weightValue / (heightInMeters * heightInMeters)
        bmi = bmiValue
        
        switch bmiValue {
        case ..<18.5:
            healthStatus = "Underweight"
            resultColor = .yellow
        case 18.5..<25:
            healthStatus = "Healthy"
            resultColor = .green
        case 25..<30:
            healthStatus = "Overweight"
            resultColor = .orange
        default:
            healthStatus = "Obese"
            resultColor = .red
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}