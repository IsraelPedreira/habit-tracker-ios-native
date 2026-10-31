import SwiftUI
import Playgrounds
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var habits: [Habit]
    @State private var showingAddHabit = false
    
    private func deleteHabits(at offsets: IndexSet) {
        for index in offsets {
            let habit = habits[index]
            modelContext.delete(habit)
        }
        // try? modelContext.save()
    }
    
    var body: some View{
        NavigationStack{
            Group{
                if(habits.isEmpty){
                    ContentUnavailableView(
                        "Sem hábitos disponíveis",
                        systemImage: "checkmark.circle",
                        description: Text("Clique no + para adicionar um hábito")
                    )
                }else{
                    List{
                        ForEach(habits){habit in
                            HStack{
                                VStack(alignment: .leading){
                                    Text(habit.name)
                                    Text("Completado \(habit.timesCompleted) vezes")
                                }
                                Spacer()
                                Button{
                                    habit.timesCompleted += 1
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .font(.title2)
                                        .foregroundStyle(.green)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .onDelete(perform: deleteHabits)
                    }
                }
            }
            .navigationTitle("Meus hábitos")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit){
                CreateHabitView()
            }
        }
    }
}

#Preview {
    ContentView()
}
