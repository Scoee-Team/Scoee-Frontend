# AGENTS.md — Flutter Frontend

## 1. Project Overview

This project is a mobile app for football score prediction among invited friends.

The app fetches football match information from an external football API through the backend, allows users to view upcoming matches, follow favorite leagues and teams, create prediction rooms, invite friends, submit predicted scores, and identify the loser based on prediction deviation after the match results are finalized.

This is not a real-money betting app. There must be no cash betting, cash-equivalent points, rewards, odds, payout, or gambling-style UX. The term "prediction" should be preferred over "betting" in UI copy.

## 2. Core Product Concept

The app has two main prediction modes.

### 2.1 Single Match Prediction Room

A user selects one football match, creates a room, invites friends, and each participant predicts the final score.

Example:

- Match: Korea vs Japan
- User A predicts 2:1
- User B predicts 1:1
- User C predicts 0:2

After the actual result is confirmed, the app calculates each participant's deviation and identifies the participant with the largest deviation as the loser.

### 2.2 Multi-Match Prediction Room

For competitions such as the World Cup, users can create a prediction room covering multiple matches.

Example:

- Room: World Cup Group A Prediction
- Matches:
  - Qatar vs Ecuador
  - Senegal vs Netherlands
  - Qatar vs Senegal
  - Netherlands vs Ecuador
  - Ecuador vs Senegal
  - Netherlands vs Qatar

Each participant predicts scores for all selected matches. After results are finalized, total deviation across all matches is calculated. The participant with the largest total deviation is selected as the loser.

## 3. Design Direction

### 3.1 Visual Style

Use a premium black theme inspired by Apple's design language.

General design principles:

- Black/dark background
- Minimal UI
- Large spacing
- Card-based layout
- Rounded corners
- Clean typography
- Subtle shadows or borders
- Strong focus on team names, logos, scores, and prediction status
- Avoid cluttered sports-betting style UI

### 3.2 Suggested Color Tokens

Use centralized design tokens.

```dart
class AppColors {
  static const background = Color(0xFF050505);
  static const surface = Color(0xFF111111);
  static const surfaceAlt = Color(0xFF1A1A1A);
  static const border = Color(0xFF2A2A2A);
  static const primaryText = Color(0xFFFFFFFF);
  static const secondaryText = Color(0xFFA0A0A0);
  static const mutedText = Color(0xFF6E6E6E);
  static const accent = Color(0xFF0A84FF);
  static const success = Color(0xFF30D158);
  static const warning = Color(0xFFFFD60A);
  static const danger = Color(0xFFFF453A);
}
```

### 3.3 UI Copy Rules

Prefer these terms:

- "스코어 예측"
- "예측방"
- "친구 초대"
- "예측 마감"
- "결과 확인"
- "편차"
- "꼴찌"

Avoid these terms:

- "배팅"
- "베팅"
- "배당"
- "오즈"
- "환급"
- "상금"
- "현금"
- "도박"

## 4. Tech Stack

Use the following stack unless the existing project uses another stack.

- Flutter
- Dart
- Riverpod or Flutter Bloc for state management
- Dio for HTTP client
- Retrofit or manual API client layer
- GoRouter for navigation
- Freezed for immutable models if possible
- json_serializable for DTO serialization
- flutter_secure_storage for token storage
- Firebase Cloud Messaging for match/prediction notifications if needed

Recommended structure:

```text
lib/
  core/
    constants/
    theme/
    router/
    network/
    storage/
    utils/
    widgets/
  features/
    auth/
    home/
    matches/
    favorites/
    prediction_rooms/
    predictions/
    rankings/
    profile/
```

## 5. Frontend Architecture

Follow a feature-first architecture.

Each feature should contain:

```text
feature_name/
  data/
    dto/
    api/
    repository_impl.dart
  domain/
    model/
    repository.dart
    usecase/
  presentation/
    screen/
    widget/
    viewmodel/ or controller/
```

Do not place business logic directly inside widgets. Keep widgets declarative and move logic to controllers, viewmodels, or state notifiers.

## 6. Main Screens

### 6.1 Onboarding Screen

Purpose:

- Introduce the service
- Let the user select favorite leagues and teams
- Request notification permission if necessary

Required UI elements:

- App logo
- Short value proposition
- Favorite league selector
- Favorite team selector
- Continue button

Example copy:

```text
친구들과 함께 경기 스코어를 예측해보세요.
가장 멀리 빗나간 친구가 오늘의 꼴찌입니다.
```

### 6.2 Home Screen

Purpose:

- Show upcoming matches
- Show favorite team matches
- Show active prediction rooms

Sections:

- Today's matches
- Favorite team matches
- Active rooms
- Recommended matches

Each match card should display:

- League name
- Home team logo/name
- Away team logo/name
- Kickoff time
- Prediction status
- CTA button

CTA examples:

- "예측하기"
- "방 만들기"
- "결과 보기"

### 6.3 Match List Screen

Purpose:

- Browse upcoming matches by date, league, and team

Required filters:

- Date
- League
- Favorite teams only
- Match status

Match statuses:

- Scheduled
- Live
- Finished
- Prediction closed

### 6.4 Match Detail Screen

Purpose:

- Display match information and allow room creation

Required UI:

- Home team vs away team
- Kickoff time
- League
- Venue if available
- Prediction deadline
- Existing rooms if the user is already invited or joined
- Create prediction room button

### 6.5 Create Prediction Room Screen

Support two room types.

#### Single Match Room

Fields:

- Room title
- Selected match
- Prediction deadline
- Visibility: invite-only
- Create button

#### Multi-Match Room

Fields:

- Room title
- Competition or league
- Match selection list
- Prediction deadline strategy
  - Same deadline for all matches
  - Deadline per match based on kickoff time
- Create button

Important UX:

For multi-match rooms, selected matches should be displayed as compact cards. The user should be able to remove matches before creating the room.

### 6.6 Prediction Room Detail Screen

Purpose:

- Show room status, participants, matches, and prediction progress

Required UI:

- Room title
- Host user
- Invite code/link
- Share invite button
- Participant list
- Match list
- My prediction status
- Overall room status

Room statuses:

- OPEN
- PARTIALLY_LOCKED
- LOCKED
- COMPLETED

For single-match rooms:

- Display one score input component.

For multi-match rooms:

- Display a list of match prediction cards.
- Each match card should show whether prediction is submitted, editable, locked, or completed.

### 6.7 Score Prediction Input Screen

Purpose:

- Let the user submit predicted scores

For each match:

- Home team
- Away team
- Home score picker
- Away score picker
- Save button

Recommended input style:

- Number stepper
- Wheel picker
- Simple plus/minus buttons

Validation:

- Score must be an integer.
- Score must be greater than or equal to 0.
- Maximum recommended score: 20.
- Prediction cannot be submitted after the prediction deadline.
- Locked matches must be read-only.

### 6.8 Result Screen

Purpose:

- Show actual result, predictions, deviation, and loser

For single match:

- Actual score
- Each participant's predicted score
- Each participant's deviation
- Loser highlight

For multi-match room:

- Total deviation table
- Match-by-match breakdown
- Loser highlight
- Tiebreaker explanation if applied

UI requirement:

Do not present the loser in an aggressive or humiliating way. Use playful copy.

Example copy:

```text
오늘의 꼴찌는 민우님입니다.
총 편차 8점으로 가장 멀리 빗나갔어요.
```

### 6.9 Ranking Screen

Purpose:

- Show room-level and season-level rankings if implemented

MVP ranking:

- Room ranking only
- Total deviation ascending/descending depending on context
- Loser is the participant with the highest deviation

Optional future ranking:

- Most accurate predictor
- Most frequent loser
- Average deviation
- Favorite team prediction accuracy

## 7. Deviation Calculation Display Rules

The backend is the source of truth for scoring and loser selection.

The frontend should display the scoring result returned by the backend.

Recommended display formula:

```text
Deviation = |predictedHomeScore - actualHomeScore| + |predictedAwayScore - actualAwayScore|
```

For multi-match rooms:

```text
Total Deviation = Sum of deviations across all finalized matches
```

Frontend should not recalculate final loser independently except for temporary local preview.

## 8. API Integration Assumptions

Base API path:

```text
/api/v1
```

### 8.1 Matches

```http
GET /api/v1/matches/upcoming
GET /api/v1/matches/today
GET /api/v1/matches/{matchId}
GET /api/v1/competitions/{competitionId}/matches
```

### 8.2 Favorites

```http
GET /api/v1/favorites
POST /api/v1/favorites/leagues/{leagueId}
DELETE /api/v1/favorites/leagues/{leagueId}
POST /api/v1/favorites/teams/{teamId}
DELETE /api/v1/favorites/teams/{teamId}
```

### 8.3 Prediction Rooms

```http
POST /api/v1/prediction-rooms
GET /api/v1/prediction-rooms/{roomId}
POST /api/v1/prediction-rooms/join
GET /api/v1/prediction-rooms/me
POST /api/v1/prediction-rooms/{roomId}/invite-link
```

### 8.4 Predictions

```http
POST /api/v1/prediction-rooms/{roomId}/predictions
PUT /api/v1/prediction-rooms/{roomId}/predictions
GET /api/v1/prediction-rooms/{roomId}/predictions/me
GET /api/v1/prediction-rooms/{roomId}/results
```

## 9. DTO Examples

### 9.1 Match Summary

```json
{
  "id": 1001,
  "leagueName": "FIFA World Cup",
  "homeTeam": {
    "id": 1,
    "name": "Korea Republic",
    "logoUrl": "https://example.com/korea.png"
  },
  "awayTeam": {
    "id": 2,
    "name": "Japan",
    "logoUrl": "https://example.com/japan.png"
  },
  "kickoffTime": "2026-06-15T20:00:00+09:00",
  "status": "SCHEDULED",
  "homeScore": null,
  "awayScore": null
}
```

### 9.2 Create Single-Match Room Request

```json
{
  "title": "오늘 한일전 스코어 예측",
  "type": "SINGLE_MATCH",
  "matchIds": [1001],
  "predictionDeadlineType": "MATCH_KICKOFF"
}
```

### 9.3 Create Multi-Match Room Request

```json
{
  "title": "월드컵 조별리그 예측방",
  "type": "MULTI_MATCH",
  "matchIds": [1001, 1002, 1003, 1004],
  "predictionDeadlineType": "EACH_MATCH_KICKOFF"
}
```

### 9.4 Submit Prediction Request

```json
{
  "predictions": [
    {
      "matchId": 1001,
      "homeScore": 2,
      "awayScore": 1
    },
    {
      "matchId": 1002,
      "homeScore": 0,
      "awayScore": 0
    }
  ]
}
```

### 9.5 Room Result Response

```json
{
  "roomId": 10,
  "roomStatus": "COMPLETED",
  "loserUserId": 3,
  "participants": [
    {
      "userId": 1,
      "nickname": "Minwoo",
      "totalDeviation": 3,
      "isLoser": false
    },
    {
      "userId": 3,
      "nickname": "Alex",
      "totalDeviation": 8,
      "isLoser": true
    }
  ],
  "matchResults": [
    {
      "matchId": 1001,
      "actualHomeScore": 2,
      "actualAwayScore": 1,
      "predictions": [
        {
          "userId": 1,
          "predictedHomeScore": 2,
          "predictedAwayScore": 0,
          "deviation": 1
        }
      ]
    }
  ]
}
```

## 10. State Management Requirements

Recommended Riverpod state structure:

```text
authProvider
favoriteLeagueProvider
favoriteTeamProvider
upcomingMatchesProvider
matchDetailProvider(matchId)
myPredictionRoomsProvider
predictionRoomDetailProvider(roomId)
roomResultProvider(roomId)
```

For score input, use local state first, then submit to backend.

Do not call the backend on every score increment/decrement. Save only when the user taps a clear save or submit button.

## 11. Error Handling

Display user-friendly messages.

Examples:

- Network error: "네트워크 연결을 확인해주세요."
- Prediction closed: "예측 마감 시간이 지나 수정할 수 없어요."
- Room not found: "존재하지 않는 예측방입니다."
- Already joined: "이미 참여한 예측방입니다."
- Match locked: "경기 시작 후에는 예측을 수정할 수 없어요."
- External API delayed: "경기 결과 업데이트가 지연되고 있어요."

## 12. Notification Requirements

Potential notifications:

- Favorite team match reminder
- Prediction deadline reminder
- Friend joined room
- Match result finalized
- Loser selected

Notification copy should remain playful and non-gambling.

Example:

```text
예측 마감 10분 전입니다.
아직 스코어를 입력하지 않은 경기가 있어요.
```

## 13. Navigation

Suggested bottom tabs:

1. Home
2. Matches
3. Rooms
4. Ranking
5. My

Use GoRouter route examples:

```text
/
 /matches
 /matches/:matchId
 /rooms
 /rooms/create
 /rooms/:roomId
 /rooms/:roomId/predict
 /rooms/:roomId/result
 /profile
```

## 14. Implementation Rules for Coding Agent

- Keep UI clean and minimal.
- Do not hardcode API URLs directly inside widgets.
- Do not put business logic in widget files.
- Use strongly typed models.
- Separate DTOs from domain models when possible.
- Handle loading, empty, error, and success states for all remote data.
- Build reusable widgets:
  - MatchCard
  - TeamLogoName
  - ScorePicker
  - PredictionStatusBadge
  - RoomCard
  - ParticipantDeviationRow
  - EmptyStateView
- Use Korean UI copy by default.
- Keep all time display localized to the user's locale.
- Treat backend as the source of truth for room status, prediction lock status, deviation, and loser result.
- Never implement real-money betting, odds, payout, or cash-equivalent rewards.

## 15. MVP Completion Criteria

The frontend MVP is complete when:

- Users can view upcoming matches.
- Users can select favorite leagues and teams.
- Users can create a single-match prediction room.
- Users can create a multi-match prediction room.
- Users can invite friends using a shareable link or invite code.
- Users can submit predicted scores.
- Users cannot edit predictions after the deadline.
- Users can view result, deviation, and selected loser.
- UI follows the black premium design direction.
