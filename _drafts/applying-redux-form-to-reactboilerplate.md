---
layout: post
title: Applying redux-form to reactboilerplate
---

react web app을 위해서 많이 사용되고 있는 [reactboilerplate](reactboilerplate.com)에 [redux-form](https://github.com/erikras/redux-form)을 적용하면서 발생한 문제들에 대한 해결팁들을 적어본다.

#### 1. immutable 사용

reactboilerplate는 redux-store 로써 [immutable.js](https://facebook.github.io/immutable-js/) 를 사용한다. 따라서 [이 링크](http://redux-form.com/6.3.1/examples/immutable/)에 나와있는 내용처럼 모든 부분에서 `'redux-form/immutable'` 내의 컴포넌트들을 사용해야 한다.

#### 2. Custom Component 사용할 때 발생하는 문제점

나는 [reactstrap](https://reactstrap.github.io/)을 react.js ui framework로 사용했는데, 여기서 제공하는 `<Input/>` 컴포넌트를 `redux-form`을 이용하여 연동하고 싶었다. 하지만 그냥은 안되고 [이 링크](http://redux-form.com/6.3.1/docs/faq/CustomComponent.md/)에 있는 것처럼 사용해야 한다. 대략 아래와 같다.

```javascript
const renderMyInput = field => (
  <Input id="idName" name="name" type="text"
         value={field.input.value}
         onChange={ev => field.input.onChange(ev.target.value)}
         placeholder="Enter name."/>
)

render() {
  return (
    ...
      <Field name="nameField" component={renderMyInput}/>
    ...
  )
}
```

이렇게 해야하는 이유는 react-component 는 `onChange` 이벤트로써 [SyntheticEvent](https://facebook.github.io/react/docs/events.html) 가 발생하기 때문이다.

#### 3. Form의 값을 store에서 읽어오는 좋은 방법

[formValueSelector](http://redux-form.com/6.3.1/docs/api/FormValueSelector.md/)를 사용하는게 가장 좋고 안전하다. 대략 아래와 같은 형태이다.

```javascript
const formSelector = state => formValueSelector('cardsPage')(state, 'nameField')

const mapStateToProps = createSelector(
  state => state.get('home').toJS(),
  formSelector,
  (h, newCardName) => {
    h.newCardName = newCardName
    return h
  }
)

export default connect(mapStateToProps, mapDispatchToProps)(reduxForm({ form: 'cardsPage' })(CardsPage))
```

특히 immutable을 사용하기 때문에 selector를 사용하는게 좋다. (참고 : [reselect](https://github.com/reactjs/reselect))

