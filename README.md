# True North – Emotional Wellbeing Companion App
## Author: Anubhav Adhikari, Kunal Pawar, Prathyush Vasa (Team NoKAP)

True North is an iOS app designed to help users track and improve their emotional wellbeing over time through journaling, mood tracking, personalized goal tracking, and reflective AI summaries. It offers both **short-term management** and **long-term growth**, encouraging users to build emotional resilience and consistency in self-care habits.

##  Features

### Short-Term Emotional Management
- Mood rating scale (1–10) to reflect the user's daily emotional state.
- Guided journal prompts to help users express and process their thoughts.
- AI-powered emotional summaries to reflect back what the user may be feeling (without offering advice or solutions).

### Long-Term Consistency & Growth
- Vision board and daily goal setting to help users define long-term personal improvement targets.
- Goals are persistently stored and added to a list that can be seen later on

### Calendar Log of Journals
- Stores user journal entries by date.
- Users can revisit any previous day's entry via a calendar view.

---

## Built With

- **Swift** & **SwiftUI** – Clean, modern iOS UI/UX
- **OpenAI API** – Used for emotional analysis of journal content
- **MVVM Architecture** – For better organization and scalability
- **EnvironmentObject & State Management** – Smooth data flow between views

---

## How to Run

1. Clone the repo and open in **Xcode 15+**
2. Add your OpenAI API Key in your secrets or request config.
3. Ensure you have network permissions in `Info.plist`:

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
