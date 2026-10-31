import SwiftUI
import SwiftData

struct CreateHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var habitName = ""
    @State private var habitDescription = ""
    
    var body: some View{
        NavigationStack{
            Form{
                Section(header: Text("Nome")){
                    TextField("Ex: Acordar", text: $habitName)
                }
                Section(header: Text("Descrição (opcional)")){
                    TextField("Ex: Acordo às 7:00", text: $habitDescription)
                }
            }
            .navigationTitle("Novo hábito")
            .toolbar{
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancelar"){
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button("Salvar"){
                        let newHabit: Habit = Habit(name: habitName, desc: habitDescription)
                        modelContext.insert(newHabit)
                        dismiss()
                    }.disabled(habitName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}

#Preview {
    CreateHabitView()
}
