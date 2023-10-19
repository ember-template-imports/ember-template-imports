import { module, test } from 'qunit';
import { setupRenderingTest } from 'ember-qunit';
import { render } from '@ember/test-helpers';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { precompileTemplate } from '@ember/template-compilation';

class WithModifier extends Component {
  click = () => {};

  <template>
    <button type="button" {{on 'click' this.click}}>Click me</button>
  </template>
}

class WithHelper extends Component {
  trueCondition = 'true';

  <template>
    {{#if (eq this.trueCondition 'true')}}
      <div>TRUE</div>
    {{/if}}
  </template>
}


module('tests/integration/components/gjs', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders a component with a modifier', async function (assert) {
    await render(
      <template>
        <WithModifier />
      </template>
    );
    assert.equal(this.element.textContent.trim(), 'Click me');
  })

  test('it renders a compoentn with a modifer with precompileTemplate', async function (assert) {
    await render(precompileTemplate(`<WithModifier />`, {
      strictMode: true,
      scope: () => ({WithModifier, on})
    }));
  })

  test('it renders a component with a helper', async function (assert) {
    await render(
      <template>
        <WithHelper />
      </template>
    );
    assert.equal(this.element.textContent.trim(), 'TRUE');
  })
});
